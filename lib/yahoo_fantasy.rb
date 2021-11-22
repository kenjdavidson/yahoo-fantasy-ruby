# frozen_string_literal: true

# YahooFantasy module.
#
# @author kenjdavidson
#
module YahooFantasy
  require 'yahoo_fantasy/version'

  class YahooFantasyError < StandardError
  end

  class MissingAccessTokenError < YahooFantasyError
  end

  autoload :Client, 'yahoo_fantasy/client'
  autoload :Resource, 'yahoo_fantasy/resource'
  autoload :XML, 'yahoo_fantasy/xml'
end
