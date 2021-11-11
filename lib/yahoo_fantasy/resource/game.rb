# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Game Resource (and by extension Collection) provides opininated functionality references by
    # https://web.archive.org/web/20130820114739/http://developer.yahoo.com/fantasysports/guide/game-resource.html
    # https://web.archive.org/web/20130821002124/http://developer.yahoo.com/fantasysports/guide/games-collection.html#games-collection-desc
    #
    class Game < YahooFantasy::Resource::Base
      autoload :GameWeek, 'yahoo_fantasy/resource/game/game_week'
      autoload :PositionType, 'yahoo_fantasy/resource/game/position_type'
      autoload :Statistic, 'yahoo_fantasy/resource/game/statistic'
      autoload :RosterPosition, 'yahoo_fantasy/resource/game/roster_position'

      subresource :leagues, YahooFantasy::Resource::League

      filter :is_available
      filter :game_types
      filter :game_codes
      filter :seasons

      attr_accessor :game_key, :game_id, :name, :code, :type, :url, :season, :is_registration_over, :is_game_over,
                    :is_offseason

      # TODO: move into Subresources? module
      # Unsure if there is a point since there aren't too many of them.  If there are consistencies
      # between Game and League subresources then this might make sense.  Although part of me hates
      # the idea of using Subresources#resource_url (or #prefix, etc) without "compile time" errors
      attr_writer :leagues, :game_weeks, :stat_categories, :position_types, :roster_positions

      def registration_over?
        is_registration_over == 1
      end

      def game_over?
        is_game_over == 1
      end

      def offseason?
        is_offseason == 1
      end

      def resource_path
        "/game/#{game_key}"
      end

      def collection_path
        "/games/game_keys=#{game_key}"
      end

      def leagues
        @leagues ||= YahooFantasy::Resource::League.all
      end

      def game_weeks
        @game_weeks ||= self.class.api(:get, "#{resource_path}/game_weeks") do |fc|
          fc.game.game_weeks
        end
      end

      def stat_categories
        @stat_categories ||= self.class.api(:get, "#{resource_path}/stat_categories") do |fc|
          fc.game.stats
        end
      end

      def position_types
        @position_types ||= self.class.api(:get, "#{resource_path}/position_types") do |fc|
          fc.game.game_weeks
        end
      end

      def roster_positions
        @roster_positions ||= self.class.api(:get, "#{resource_path}/roster_positions") do |fc|
          fc.game.game_weeks
        end
      end
    end
  end
end
