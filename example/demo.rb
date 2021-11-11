#!/usr/bin/env ruby
# Run through bundle exec demo.rb

require 'yaml'
require 'oauth2'
require 'yahoo_fantasy'

client_config = YAML.load_file './.client.yml'

client = YahooFantasy::Client.new(client_config['client']['client_id'],
                                  client_config['client']['client_secret'],
                                  scope: client_config['client']['scope'])

access_token = OAuth2::AccessToken.from_hash(client, client_config['token'])
puts access_token.token
puts access_token.refresh_token

access_token = access_token.refresh!
puts access_token.token
puts access_token.refresh_token

response = access_token.request(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/league/406.l.117376')
puts "Raw: #{response.body}"

content = YahooFantasy::XML::FantasyContentRepresenter.new(YahooFantasy::Resource::FantasyContent.new).from_xml(response.body)
puts content
puts content.league
