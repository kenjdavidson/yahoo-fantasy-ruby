# frozen_string_literal: true

require 'yahoo_fantasy/resource/subresources'
require 'yahoo_fantasy/resource/filters'

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
      include YahooFantasy::Resource::Subresources
      include YahooFantasy::Resource::Filters

      # Set the OAuth2 (or #request) access token to be used for all requests by the current thread.
      #
      # @param [AccessToken] access_token the access token providing a #request method
      #
      def self.access_token=(access_token)
        unless access_token.respond_to?(:request)
          raise ArgumentError,
                'access_token must respond to #request method'
        end

        Thread.current[:yahoo_fantasy_access_token] = access_token
      end

      # @return [OAuth2::AccessToken] the current threads access token
      #
      def self.access_token
        Thread.current[:yahoo_fantasy_access_token]
      end

      # @return [Boolean] whether there is a current access token
      #
      def self.access_token?
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
      def self.api(verb, path, opts = {})
        response = access_token.request(verb, path, opts)
        response = response.parsed
        response = yield(response) if block_given?
        response
      end
    end
  end
end
