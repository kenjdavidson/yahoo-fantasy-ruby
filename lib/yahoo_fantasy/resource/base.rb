# frozen_string_literal: true

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
        # @param [String] path passed to the access_token#request
        # @param [Hash] opts passed to the access_token#request
        # @param [Block] if a block is provided the response is filtered through it
        # @return [YahooContent,YahooFantasy::Resource::Base] the yahoo content response
        #
        # @raise [MissingAccessTokenError]
        def api(verb, path, opts = {}, &block)
          raise YahooFantasy::MissingAccessTokenError, 'An OAuth2::AccessToken or {}#request must be provided' if access_token.nil?

          response = access_token.request(verb, path, opts)
          response = response.parsed
          response = block.call(response) if block_given?
          response
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

      # Alias instance method to the Base.api method.  There could be
      # a better way to do this (method_alias?) but for now this works
      #
      def api(verb, path, opts = {}, &block)
        self.class.api(verb, path, opts, block)
      end
    end
  end
end
