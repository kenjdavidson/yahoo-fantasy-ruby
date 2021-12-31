# frozen_string_literal: true

require 'omniauth-oauth2'
require 'yahoo_fantasy/client'

module OmniAuth
  module Strategies
    # Implementation of (@see OmniAuth::Strategies::OAuth2) following the Yahoo OAuth2
    # specification.  One of the key features of the Yahoo OAuth2 login is that the
    # redirect_uri allows for `oob` as an option (regardless of configuration).
    #
    # When providing `oob` as the redirect_uri this strategy will not redirect, it will set the
    # `session['omniauth.redirect_uri']` and call through to the next middleware.  If `oob` is
    # set, then you must provide either an `OmniAuth::Form` or handle the `/auth/yahoo` within
    # your application accordingly.
    #
    # @see https://developer.yahoo.com/oauth2/guide/
    # @see https://github.com/omniauth/omniauth/blob/master/lib/omniauth/strategy.rb
    # @see https://github.com/omniauth/omniauth-oauth2/blob/master/lib/omniauth/strategies/oauth2.rb
    #
    # Assumes the following configuration items:
    # - request_path of `/auth/yahoo`
    # - callback_path of `/auth/yahoo/callback`
    #
    class YahooOAuth < OmniAuth::Strategies::OAuth2
      # Provides options[:name] for the #callback_url
      option :name, 'yahoo'

      option :userinfo_url, '/openid/v1/userinfo'
      option :request_path, '/auth/yahoo'
      option :callback_path, '/auth/yahoo/callback'

      # @return [YahooFantasy::Client] the yahoo fantasy client
      def client
        YahooFantasy::Client.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
      end

      # Called from the OmniAuth::Strategy#request_call when no `options.form` is provided
      # (generally an OmniAuth::Form).  The only difference here is that Yahoo Fantasy provides
      # the call back `oob` (Out of Bounds) which will present the user with the code on the
      # screen and require it to be entered manually.
      #
      def request_phase
        options.client_options[:redirect_uri] == 'oob' ? oob_phase : super
      end

      # Overrides callback_url to allow for `oob`.  Generally the `callback_url` will be exactly what
      # we would expect (full_host + calllback_path + query_string) but in the case of `oob` it needs
      # to not.
      def callback_url
        options.client_options[:redirect_uri] == 'oob' ? 'oob' : super
      end

      # @see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema uid
      # @see https://developer.yahoo.com/oauth2/guide/get-user-inf/Get-User-Info-API.html
      uid do
        raw_info['sub']
      end

      # @see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema info
      # @see https://developer.yahoo.com/oauth2/guide/get-user-inf/Get-User-Info-API.html
      info do
        {
          name: raw_info['name'],
          email: raw_info['email'],
          nickname: raw_info['nickname'],
          first_name: raw_info['given_name'],
          last_name: raw_info['family_name'],
          description: raw_info['description'],
          location: raw_info['locale'],
          image: raw_info['picture']
        }
      end

      # @see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema info
      extra do
        log :debug, "parsing auth schema extra (raw): #{@raw_info}"
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(options.userinfo_url).parsed
      end

      private

      # Sets `env` keys:
      # - `omniauth.redirect_url`
      # - `omniauth.callback_path`
      #
      # then continues application flow.
      #
      def oob_phase
        log :debug, 'out of bounds phase initiated.'
        log :debug, 'env[omniauth.redirect_url] and env[omniauth.callback_path] now available'
        env['omniauth.redirect_url'] = client.auth_code.authorize_url({ redirect_uri: callback_url }.merge(authorize_params))
        env['omniauth.callback_path'] = callback_path
        call_app!
      end
    end
  end
end

OmniAuth.config.add_camelization 'yahoo_oauth', 'YahooOAuth'
