# frozen_string_literal: true

require 'oauth2'

# YahooFantasy module.
#
# By loading the YahooFantasy module you're also making the `OAuth2::Response` parser `:yahoo_fantasy_content`
# available.  By using this parser all responses will be parsed into `YahooFantasy::Resource::FantasyContent`.
#
# @author kenjdavidson
#
module YahooFantasy
  # Quick and dirty initialization of classes
  module Initializable
    def initialize(params = {})
      params.each do |key, value|
        setter = "#{key}="
        send(setter, value) if respond_to?(setter.to_sym, false)
      end
    end
  end

  require 'yahoo_fantasy/version'

  # MissingAccessTokenError
  #
  class MissingAccessTokenError < StandardError
  end

  autoload :YahooFantasyError, 'yahoo_fantasy/yahoo_fantasy_error'
  autoload :Client, 'yahoo_fantasy/client'
  autoload :Resource, 'yahoo_fantasy/resource'
  autoload :XML, 'yahoo_fantasy/xml'

  Games = YahooFantasy::Resource::Game::Game
  Leagues = YahooFantasy::Resource::League::League
end

# We don't want to overwrite the defaults for the mime types
# 'text/xml', 'application/rss+xml', 'application/rdf+xml', 'application/atom+xml', 'application/xml'
OAuth2::Response.register_parser(:yahoo_fantasy_content, []) do |body|
  fc = YahooFantasy::Resource::FantasyContent.new
  YahooFantasy::XML::FantasyContentRepresenter.new(fc).from_xml(body)
end
