# Loading and configuration of the Yahoo security features.
# https://github.com/omniauth/omniauth

require 'omniauth'
require 'yahoo_omniauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  puts "Yahoo OAuth Config: #{Rails.configuration.yahoo_oauth}"
  provider :yahoo_oauth, Rails.configuration.yahoo_oauth.client_id, Rails.configuration.yahoo_oauth.client_secret,
           client_options: {
             redirect_uri: Rails.configuration.yahoo_oauth.redirect_uri,
             scope: Rails.configuration.yahoo_oauth.scope
           }
end
