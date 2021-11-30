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

      # This is a hack.  The response with an error is <yahoo:error> while the good
      # response is <fantasy_content>; it would be awesome if you could switch the type
      # during deserialization without doing funky things, but for now
      # since we know that fantasy_content never has a description child, if we find it
      # it's an error.
      property :error, as: :description

      property :lang, attribute: true
      property :uri, attribute: true
      property :copyright, attribute: true
      property :refresh_rate, attribute: true

      property :game, decorator: YahooFantasy::XML::Game::GameRepresenter,
                      class: YahooFantasy::Resource::Game::Game
      property :league, decorator: YahooFantasy::XML::League::LeagueRepresenter,
                        class: YahooFantasy::Resource::League::League
      property :team, decorator: YahooFantasy::XML::Team::TeamRepresenter,
                      class: YahooFantasy::Resource::Team::Team

      collection :games, as: :game, wrap: :games,
                         decorator: YahooFantasy::XML::Game::GameRepresenter,
                         class: YahooFantasy::Resource::Game::Game
    end
  end
end
