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
# puts access_token.token
# puts access_token.refresh_token

access_token = access_token.refresh!
# puts access_token.token
# puts access_token.refresh_token

response = access_token.request(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/league/406.l.117376;out=settings')
content = YahooFantasy::XML::FantasyContentRepresenter.new(YahooFantasy::Resource::FantasyContent.new).from_xml(response.body)
puts content

YahooFantasy::Resource::Base.access_token = access_token
game = YahooFantasy::Resource::Game::Game.get(406).game
puts "Game: #{game.code.upcase}"

begin
  test = YahooFantasy::Resource::Base.api(:get, '/imaginary')
  puts test.to_s
rescue StandardError => e
  puts e.fantasy_content.uri
  puts e.message
end
