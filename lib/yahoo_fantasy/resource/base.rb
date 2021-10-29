module YahooFantasy
  module Resource
    class Base 
      include YahooFantasy::Resource::Subresources
      include YahooFantasy::Resource::Filters

      # Set the OAuth2 (or #request) access token to be used for all requests by the current thread.
      # @param [AccessToken] access_token the access token providing a #request method
      def self.access_token=(access_token)
        raise ArgumentError, "Access token provided does not respond to #request method" unless access_token.respond_to?(:request)
        Thread.current[:yahoo_fantasy_access_token] = access_token
      end 

      def self.access_token 
        Thread.current[:yahoo_fantasy_access_token]
      end 

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
      def self.api(verb, path, opts = {})
        response = access_token.request(verb, path, opts)
        response.parsed
      end 

    end
  end
end