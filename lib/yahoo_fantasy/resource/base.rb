# frozen_string_literal: true

require 'active_support/core_ext/string'

module YahooFantasy
  module Resource
    # Base
    #
    # Provides a common functionality for all Yahoo Fantasy resources.  All resources should (generally) have
    # a set of sub-resources and filters.  All resources should also use the same OAuth2 AccessToken
    # when performing queries - the AccessToken is a thread specific value which needs to be managed
    # appropriately.
    #
    # Coming from the Java world this would be an `abstract class Base` although with Ruby I believe
    # that it should be refactored into a module ::Resource.  Which would mean the Resource module
    # should probably become ::Api.
    #
    # @todo from my understanding "abstract" classes are bad form.  This needs to be split into different
    #   modules.  Maybe: Api (access_token and call), Resource (get), Collection (all), etc??
    #
    class Base
      include YahooFantasy::Resource::Subresourceable
      include YahooFantasy::Resource::Filterable

      BASE_PATH = 'https://fantasysports.yahooapis.com/fantasy/v2'

      class << self
        # Set the OAuth2 (or #request) access token to be used for all requests by the current thread.
        #
        # @param access_token [OAuth2::AccessToken] access_token the access token providing a #request method
        #
        def access_token=(access_token)
          raise ArgumentError, 'access_token must respond to #request method' unless access_token.respond_to?(:request) || access_token.nil?

          Thread.current[:yahoo_fantasy_access_token] = access_token
        end

        # @return [OAuth2::AccessToken] the current threads access token
        #
        def access_token
          Thread.current[:yahoo_fantasy_access_token]
        end

        # @return [Boolean] whether there is a current access token
        #
        def access_token?
          Thread.current.key? :yahoo_fantasy_access_token
        end

        # Sends the requested URI through the access_token#request.  By default this will return a
        # FantasyContent object that can be parsed appropriately based on the request.  It's
        # possible to skip the parsing (returning the regular body content).
        #
        # @param verb [String,Symbol] verb passed to the access_token#request
        # @param path [String] path passed to the access_token#request.  The path can be in the form
        #   `https://somepath/someresource` or `/path`; if the latter it will have the base endpoint
        #   prefixed.
        # @param opts [Hash] options passed to the access_token#request
        # @param block [Block] if a block is provided the response is filtered through it
        # @return [FantasyContent,YahooFantasy::Resource::Base] the yahoo content response
        #
        # @raise [MissingAccessTokenError] if no OAuth2::AccessToken has been provided
        #
        def api(verb, path, opts = {}, &block)
          raise YahooFantasy::MissingAccessTokenError, 'An OAuth2::AccessToken or #request class must be provided' if access_token.nil?

          response = access_token.request(verb, build_uri(path), opts).parsed
          response = block.call(response) if block_given?
          response
        end

        # @return [String] the prefixed path if not already containing `http`
        #
        def build_uri(path)
          return [base_path, path].join unless path.start_with? 'http'

          path
        end

        # @return [String] the resources base path
        #
        def base_path
          BASE_PATH
        end

        # Gets a collection of resources and subresources (outable).
        #
        # @todo maybe move this into a ::Collections
        # @todo fix for rubocop
        # @todo implement request building logic where levels of resources can be applied
        #   in order to get something like:
        #   Game.where(game_key: '1234')
        #       .include(settings)
        #       .include(leagues)
        #       .include(teams)
        #       .all()
        #
        # @param options [Hash] request options (@see OAuth2::AccessToken#request)
        # @option options [Hash{String => Array<String,Numeric>}] filters
        # @option options [Array<String>,String] out
        # @option options [String] query if you'd like to provide a custom query string, this gets
        #   applied after filters and out options.
        # @return [YahooFantasy::Resource::FantasyContent] the fantasy content response, unless a block is
        #   provided, in which case the block should parse the appropriate content from the FantasyContent
        # @yield [YahooFantasy::Resource::FantasyContent] gives the fantasy content back for parsing
        # @yieldreturn [fantasy::Resource::Base] generally a parsed resource for which you are requesting
        #
        def all(options = {}, &block)
          request_path = +''
          request_path << collection_path
          request_path << filter_params(options.delete(:filters)) if options.key?(:filters)
          request_path << out_params(options.delete(:out)) if options.key?(:out)
          request_path << options.delete(:query) if options.key?(:query)

          api(:get, request_path, options, &block)
        end

        # Gets a single resource and subresources (outable).  At this point in
        # time major subresources and filters are not available, if you're looking
        # for a custom request you can query the api directly through the
        # YahooFantasy::Resource::Game.api() method directly.
        #
        # @todo maybe move this into a ::Collections module
        #
        # @param key [String] the resource key
        # @param options [Hash] @see OAuth2::AccessToken#request
        # @option options [String,Array<String>] :out list of outable subresources
        # @option options [String] query if you'd like to provide a custom query string, this gets
        #   applied after filters and out options.
        # @return [YahooFantasy::Resource::FantasyContent] the fantasy content response
        # @yield [YahooFantasy::Resource::FantasyContent] gives the fantasy content back for parsing
        #
        def get(key, options = {}, &block)
          request_path = +"#{resource_path}/#{key}"
          request_path << out_params(options.delete(:out)) if options.key?(:out)
          request_path << options.delete(:query) if options.key?(:query)

          api(:get, request_path, options, &block)
        end

        # @return [String] thre resource path, at this point this is just the lowercase name
        #   of the resource class but eventually it should be customizable
        # @todo this probably needs to be customizable
        #
        def collection_path
          @collection_path ||= "/#{resource_name}".pluralize
        end

        # @return [String] the resource path, at this point this is just the lowercase name
        #   of the resource class but eventually it should be customizable
        #
        def resource_path
          @resource_path ||= "/#{resource_name}"
        end

        # @return [String] the default resource name of the current class downcased and
        #   underscored (singular)
        def resource_name
          @resource_name ||= to_s.split('::').last.underscore.downcase
        end
      end

      # Defines a new instance using the provied attributes.  Unknown attributes
      # are ignored at this point - although I'm sure there's a better way to do
      # this.
      #
      # @param attrs [Hash] instance variable hash
      #
      def initialize(attrs = {})
        attrs.each do |k, v|
          send("#{k}=", v) if respond_to? "#{k}="
        end
      end

      # Alias to the `.api` method.  Rails has `delegate` which seems to make more
      # sense, but for now this will work fine.
      #
      # @see .api
      #
      def api(verb, path, opts = {}, &block)
        self.class.api(verb, path, opts, &block)
      end

      # Default resource path is provided by looking up `/resource_name/resource_key`.
      #
      # @example
      #   class YahooFantasy::Resource::Game::Game.resource_path # => /game/[game_key]
      #
      # @return [String] the resource path
      #
      def resource_path
        key = instance_variable_get("@#{self.class.resource_name}_key")
        "#{self.class.resource_path}/#{key}"
      end
    end
  end
end
