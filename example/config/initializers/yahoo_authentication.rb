# Loading and configuration of the Yahoo security features.
# https://github.com/omniauth/omniauth

require 'omniauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  puts "yahoo config: #{Rails.configuration.yahoo_oauth}"
  provider :yahoo_oauth, Rails.configuration.yahoo_oauth
end
