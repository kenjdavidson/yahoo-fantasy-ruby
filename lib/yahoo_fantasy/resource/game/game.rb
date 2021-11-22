# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Game Resource (and by extension Collection) provides opininated functionality references by
      # https://web.archive.org/web/20130820114739/http://developer.yahoo.com/fantasysports/guide/game-resource.html
      # https://web.archive.org/web/20130821002124/http://developer.yahoo.com/fantasysports/guide/games-collection.html#games-collection-desc
      #
      # I'm completely torn as to whether this should actually be called Meta, since
      # YahooFantasy::Resource::Game::Meta is more inline with how Yahoo actually describes their
      # API, it just doesn't feel right.  Although equally not right feeling is duplicating
      # YahooFantasy::Resource::Game::Game.  I'm sure there is a best practice that I'm
      # missing to get around this.
      #
      # Eventually if it becomes a query like `YahooFantasy::Client.games('nfl')` it might make more sense
      # to be called Meta.
      #
      class Game < YahooFantasy::Resource::Base
        subresource :leagues, YahooFantasy::Resource::League::League
        subresource :game_weeks, YahooFantasy::Resource::Game::GameWeek
        subresource :stat_categories, YahooFantasy::Resource::Game::Statistic
        subresource :position_types, YahooFantasy::Resource::Game::PositionType
        subresource :roster_positions, YahooFantasy::Resource::Game::RosterPosition

        filter :is_available
        filter :game_types
        filter :game_codes
        filter :seasons

        attr_accessor :game_key, :game_id, :name, :code, :type, :url, :season, :is_registration_over, :is_game_over,
                      :is_offseason

        def resource_path
          "/game/#{game_key}"
        end

        def leagues!
          @leagues ||= YahooFantasy::Resource::League.all
        end

        def game_weeks!
          @game_weeks ||= self.class.api(:get, "#{resource_path}/game_weeks") do |fc|
            fc.game.game_weeks
          end
        end

        def stat_categories!
          @stat_categories ||= self.class.api(:get, "#{resource_path}/stat_categories") do |fc|
            fc.game.stats
          end
        end

        def position_types!
          @position_types ||= self.class.api(:get, "#{resource_path}/position_types") do |fc|
            fc.game.game_weeks
          end
        end

        def roster_positions!
          @roster_positions ||= self.class.api(:get, "#{resource_path}/roster_positions") do |fc|
            fc.game.game_weeks
          end
        end
      end
    end
  end
end
