require "representable/xml"

module YahooFantasy 
  module XML 
    class GameRepresenter  < Representable::Decorator
      include Representable::XML
      
      property :game_key, parse_filter: INTEGER_PARSER
      property :game_id, parse_filter: INTEGER_PARSER
      property :name
      property :code 
      property :type 
      property :url
      property :season, parse_filter: INTEGER_PARSER
      property :is_registration_over, parse_filter: INTEGER_PARSER
      property :is_game_over, parse_filter: INTEGER_PARSER
      property :is_offseason, parse_filter: INTEGER_PARSER

      collection :leagues, as: :league, wrap: :leagues,
        class: YahooFantasy::Resource::League,
        decorator: YahooFantasy::XML::LeagueRepresenter
      collection :game_weeks, as: :game_week, wrap: :game_weeks,
        class: YahooFantasy::Resource::Game::GameWeek do 
        property :week, parse_filter: INTEGER_PARSER
        property :display_name
        property :start 
        property :end
      end 
      collection :position_types, as: :position_type, wrap: :position_types,
        class: YahooFantasy::Resource::Game::PositionType do 
        property :type
        property :display_name 
      end 
      collection :roster_positions, as: :roster_position, wrap: :roster_positions,
        class: YahooFantasy::Resource::Game::RosterPosition do 
        property :position
        property :abbreviation
        property :display_name 
        property :position_type 
      end 
    end
  end 
end 