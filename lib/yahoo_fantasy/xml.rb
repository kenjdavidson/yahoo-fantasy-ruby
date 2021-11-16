# frozen_string_literal: true

module YahooFantasy
  # XML Parsing module.
  #
  module XML
    XMLNS_NS = 'http://fantasysports.yahooapis.com/fantasy/v2/base.rng'
    YAHOO_NS = 'http://www.yahooapis.com/v1/base.rng'

    autoload :Parsers, 'yahoo_fantasy/xml/parsers'
    autoload :BaseRepresenter, 'yahoo_fantasy/xml/base_representer'
    autoload :FantasyContentRepresenter, 'yahoo_fantasy/xml/fantasy_content_representer'
    autoload :Game, 'yahoo_fantasy/xml/game'
    autoload :League, 'yahoo_fantasy/xml/league'
  end
end
