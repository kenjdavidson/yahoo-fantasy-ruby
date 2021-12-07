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
        #
        # @param options [Hash] request options (@see OAuth2::AccessToken#request)
        # @option options [Hash{String => Array<String,Numeric>}] filters
        # @option options [Array<String>] :keys
        # @option options [Hash{String => String}] :filters
        # @option options [Array<String>] :out
        #
        def all(filters, options = {}, &block)
          opts = options.dup
          request_path = collection_path
          request_path << filter_params(filters)
          request_path << out_params(options.delete(:subresources)) if opts.key?(:subresources)
          api(:get, request_path, opts, &block)
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
        # @option options [String,Array<String>] :subresource list of outable subresources
        # @return [YahooFantasy::Resource::FantasyContent] the yahoo fantasy result
        #
        def get(key, options = {}, &block)
          opts = options.dup
          request_path = "#{resource_path}/#{key}".dup # Annoying frozen String
          request_path << out_params(options.delete(:subresources)) if opts.key?(:subresources)
          api(:get, request_path, options, &block)
        end

        protected

        # @return [String] thre resource path, at this point this is just the lowercase name
        #   of the resource class but eventually it should be customizable
        # @todo this probably needs to be customizable
        #
        def collection_path
          @collection_path ||= "/#{to_s.split('::').last}".pluralize.underscore.downcase
        end

        # @return [String] the resource path, at this point this is just the lowercase name
        #   of the resource class but eventually it should be customizable
        #
        def resource_path
          @resource_path ||= "/#{to_s.split('::').last}".underscore.downcase
        end

        # @return [String] the resource key filter.  This filter uses the appropriate key_name
        #   to build the keys
        #
        def key_params(keys = [])
          return ";#{key_name}=#{keys.join(',')}" unless keys.empty?

          ''
        end

        # Each resource is responsible for providing it's own key name, otherwise it will default
        # to the class name.
        #
        # @example
        #   class Game < Resource::Base; end
        #   key_name = Game.key_name # => "game_keys"
        #
        # @return [String] they resources key name
        #
        def key_name
          @key_name ||= to_s.split('::').last.to_s.underscore.downcase.to_sym
        end

        # Builds the filter String, which is pretty much the same as the key string.  Basically
        # a semi-colon separated list key/value pairs of comma separated values.
        #
        # @param filters [Hash{String => Array<String>}]
        # @return [String]
        #
        def filter_params(filters = {})
          return '' if filters.nil? || filters.empty?

          filter_string = filters.select { |k| self.filters.key?(k) }
                                 .map { |k, v| "#{k}=#{[v].join(',')}" }
                                 .join(';')
          filter_string = ";#{filter_string}" unless filter_string.empty?
          filter_string
        end

        # Builds the `;out=` string based on the provided out values.  At this point
        # they should only be Strings.
        #
        # @param out [String,Array<String>] list of outable subresources
        # @return [String] compiled out string
        #
        def out_params(out = [])
          out_params = case out
                       when String
                         ";out=#{out}" unless out.empty?
                       when Array
                         ";out=#{out.join(',')}" unless out.empty?
                       end

          out_params = '' if out_params.nil?
          out_params
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

      # Default implementation provides the classes `resource_path` value.  This would generally be
      # an abstract/interface method in Java and would require overridding in all subclasses.
      #
      # @return [String] the resource path
      #
      def resource_path
        self.class.resource_path
      end
    end
  end
end
