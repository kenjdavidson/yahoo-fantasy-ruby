module YahooFantasy
  module XML
    class FantasyContentRepresenter < Representable::Decorator
      include Representable::XML

      property :lang, attribute: true, as: "xml:lang"
      property :uri, attribute: true, as: "yahoo:uri"
      property :copyright, attribute: true
      property :refresh_rate, attribute: true
      property :xmlns, attribute: true 

      collection :users, decorator: YahooFantasy::XML::UserRepresenter, class: YahooFantasy::Resource::User
      collection :games, decorator: YahooFantasy::XML::GameRepresenter, class: YahooFantasy::Resource::Game
      collection :leagues, decorator: YahooFantasy::XML::LeagueRepresenter, class: YahooFantasy::Resource::League
            
      property :game, decorator: YahooFantasy::XML::GameRepresenter, class: YahooFantasy::Resource::Game
      property :league, decorator: YahooFantasy::XML::LeagueRepresenter, class: YahooFantasy::Resource::League      
  end 
end 