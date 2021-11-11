# frozen_string_literal: true

# YahooFantasy module.
#
# @author kenjdavidson
#
module YahooFantasy
  require 'yahoo_fantasy/version'

  # Yahoo Fantasy API specific error to be extended and thrown as needed
  #
  class YahooFantasyError < StandardError; end

  autoload :Client, 'yahoo_fantasy/client'
  autoload :Resource, 'yahoo_fantasy/resource'
  autoload :XML, 'yahoo_fantasy/xml'
end
