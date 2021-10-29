require "yahoo_fantasy/resource/league"

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base 
      require "yahoo_fantasy/resource/game/game_week"
      require "yahoo_fantasy/resource/game/stat_category"
      require "yahoo_fantasy/resource/game/position_type"
      require "yahoo_fantasy/resource/game/roster_position"
      
      subresource :leagues, YahooFantasy::Resource::League
      subresource :game_weeks, YahooFantasy::Resource::Game::GameWeek
      subresource :stat_categories, YahooFantasy::Resource::Game::StatCategory
      subresource :position_types, YahooFantasy::Resource::Game::PositionType
      subresource :roster_positions, YahooFantasy::Resource::Game::RosterPosition

      filter :is_available 
      filter :game_types
      filter :game_codes 
      filter :seasons

      attr_accessor :game_key
      attr_accessor :game_id 
      attr_accessor :name
      attr_accessor :code 
      attr_accessor :type 
      attr_accessor :url
      attr_accessor :season 
      attr_accessor :is_registration_over
      attr_accessor :is_game_over
      attr_accessor :is_offseason

      # TODO move these into the Subresources so that each creates a
      # subresource= and subresource methods, where the read methond
      # performs the appropriate request
      attr_writer :leagues, :game_weeks, :stat_categories, :position_types, :roster_positions

      def is_registration_over?
        1 == is_registration_over
      end 

      def is_game_over?
        1 == is_game_over
      end 

      def is_offseason?
        1 == is_offseason
      end

      def leagues
        @leagues ||= YahooFantasy::Resource::League.all
      end 

      # Provides the Array<GameWeek> for the current Game.  If the game_weeks
      # aren't already available, a request is made to the game_weeks 
      # subresource.
      #
      # @return Array<GameWeek>
      def game_weeks       
        @game_weeks ||= self.class.api(:get, build_subresource_path("game_weeks"))
      end 

      def stat_categories       
        @stat_categories ||= self.class.api(:get, build_subresource_path("stat_categories"))
      end 

      def position_types       
        @position_types ||= self.class.api(:get, build_subresource_path("position_types"))
      end 

      def roster_positions       
        @roster_positions ||= self.class.api(:get, build_subresource_path("roster_positions"))
      end 

    private 

      def build_subresource_path(subresource)
        "/game/#{game_key}/#{subresource}"
      end 
    end    
  end 
end
