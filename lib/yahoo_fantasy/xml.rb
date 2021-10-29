# frozen_string_literal: true

module YahooFantasy
  module XML
    INTEGER_PARSER = ->(fragment, _options) { fragment.to_i }
  end
end

require 'yahoo_fantasy/xml/league_representer'
require 'yahoo_fantasy/xml/game_representer'
