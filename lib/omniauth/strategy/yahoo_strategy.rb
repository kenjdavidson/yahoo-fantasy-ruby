# frozen_string_literal: true

# YahooFantasy module.
#
# @author kenjdavidson
#
module OmniAuth
  module Strategies
    class YahooFantasyAuth < OmniAuth::Strategies::OAuth2
      option :name, 'yahoo_fantasy_auth'
    end
  end
end
