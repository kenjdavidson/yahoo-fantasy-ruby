# frozen_string_literal: true

module YahooFantasy
  module XML
    # Represents the main XML structure for all Yahoo Fantasy API requests.  All requrests
    # return a <fantasy_content> XML containing the requested resources.  These resources
    # need to be parsed and mapped accordingly based on the requested content.
    class FantasyContentRepresenter < YahooFantasy::XML::BaseRepresenter
      # namespace YahooFantasy::XML::XMLNS_NS
      # namespace_def xmlns: YahooFantasy::XML::XMLNS_NS
      # namespace_def yahoo: YahooFantasy::XML::YAHOO_NS
      remove_namespaces!

      property :lang, attribute: true
      property :uri, attribute: true
      property :copyright, attribute: true
      property :refresh_rate, attribute: true

      property :game, decorator: YahooFantasy::XML::Game::GameRepresenter,
                      class: YahooFantasy::Resource::Game::Game
      property :league, decorator: YahooFantasy::XML::League::LeagueRepresenter,
                        class: YahooFantasy::Resource::League::League
    end
  end
end
