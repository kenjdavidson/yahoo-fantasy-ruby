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
    #
    class YahooOAuth < OmniAuth::Strategies::OAuth2
      # Provides options[:name] for the #callback_url
      option :name, 'yahoo'

      option :userinfo_url, '/openid/v1/userinfo'

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
        if options.client_options[:redirect_uri] == 'oob' # redirect
          session['omniauth.redirect_url'] = client.auth_code.authorize_url({ redirect_uri: callback_url }.merge(authorize_params))
          call_app!
        else
          super
        end
      end

      # @see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema uid
      # @see https://developer.yahoo.com/oauth2/guide/get-user-inf/Get-User-Info-API.html
      uid { raw_info['sub'] }

      # @see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema info
      # @see https://developer.yahoo.com/oauth2/guide/get-user-inf/Get-User-Info-API.html
      info do
        {
          name: raw_info.fetch(:name, ''),
          email: raw_info.fetch(:email),
          nickname: raw_info.fetch(:name, raw_info.fetch(:name, '')),
          first_name: raw_info.fetch(:given_name, raw_info['name'].split.first),
          last_name: raw_info.fetch(:family_name, raw_info['name'].split.last),
          description: raw_info['picture'],
          image: raw_info.dig(:profile_images, :image_64)
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(options.userinfo_url).parsed
      end
    end
  end
end
