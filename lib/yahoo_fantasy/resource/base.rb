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
    class Base
      include YahooFantasy::Resource::Subresourceable
      include YahooFantasy::Resource::Filterable

      BASE_PATH = 'https://fantasysports.yahooapis.com/fantasy/v2'

      class << self
        # Set the OAuth2 (or #request) access token to be used for all requests by the current thread.
        #
        # @param [AccessToken] access_token the access token providing a #request method
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
        # @param [String] verb passed to the access_token#request
        # @param [String] path passed to the access_token#request.  The path can be in the form
        #   `https://somepath/someresource` or `/path`; if the latter it will have the base endpoint
        #   prefixed.
        # @param [Hash] opts passed to the access_token#request
        # @param [Block] if a block is provided the response is filtered through it
        # @return [FantasyContent,YahooFantasy::Resource::Base] the yahoo content response
        #
        # @raise [MissingAccessTokenError]
        #
        def api(verb, path, opts = {}, &block)
          raise YahooFantasy::MissingAccessTokenError, 'An OAuth2::AccessToken or #request class must be provided' if access_token.nil?

          response = access_token.request(verb, build_uri(path), opts)
          response = response.parsed
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

        # @return [String] thre resource path prefix, at this point this is just the lowercase name
        #   of the resource class but eventually it should be customizable
        # @todo this probably needs to be customizable
        #
        def resource_prefix
          "/#{to_s.split('::').last}".underscore.downcase
        end

        # Gets a collection of resources and subresources (outable).
        #
        # @param key [String] the resource key
        # @param out [Array<String>] outable subresources
        #
        def all(filters: [], out: []); end

        # Gets a single resource and subresources (outable).  At this point in
        # time major subresources and filters are not available, if you're looking
        # for a custom request you can query the api directly through the
        # YahooFantasy::Resource::Game.api() method directly.
        #
        # @param key [String] the resource key
        # @param out [Array<String>] outable subresources
        #
        def get(key, out: [], options: {})
          resource_path = "#{resource_prefix}/#{key}#{build_out(out)}"
          api(:get, resource_path, options)
        end

        private

        # @param out [Array<String>] list of outable subresources
        # @return [String] compiled out string
        #
        def build_out(out = [])
          return ";out=#{out.join(',')}" unless out.empty?

          ''
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

      # Provide the resources own path.. This is also used by Subresourceable when creating full paths.
      #
      # @return [String] the resource path
      #
      def resource_path; end
    end
  end
end
