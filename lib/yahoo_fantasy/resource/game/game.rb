# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Provides access and implementation of Game resource and collection:
      #
      # Resource
      #
      # https://developer.yahoo.com/fantasysports/guide/#game-resource
      # https://web.archive.org/web/20130820114739/http://developer.yahoo.com/fantasysports/guide/game-resource.html
      #
      # Collection
      #
      # https://developer.yahoo.com/fantasysports/guide/#games-collection
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
      # @!attribute leagues
      #   @return [YahooFantasy::Resource::League::League] the game associated league(s)
      # @!attribute game_weeks
      #   @return [Array<YahooFantasy::Resource::Game::GameWeek>] the weeks for which this game is active
      # @!attribute stat_categories
      #   @return [Array<YahooFantasy::Resource::Game::Statistic>] the statistics availble for this game
      # @!attribute position_types
      #   @return [Array<YahooFantasy::Resource::Game::PositionType>] the positions types available within this game
      # @!attribute roster_positions
      #   @return [Array<YahooFantasy::Resource::Game::RosterPosition>] the roster positions within the position types
      #
      class Game < YahooFantasy::Resource::Base
        filter :game_keys
        filter :is_available
        filter :game_types
        filter :game_codes
        filter :seasons

        subresource :leagues, parser: ->(fc) { fc.game.leagues }
        subresource :game_weeks, parser: ->(fc) { fc.game.game_weeks }
        subresource :stat_categories, parser: ->(fc) { fc.game.stats }
        subresource :position_types, parser: ->(fc) { fc.game.position_types }
        subresource :roster_positions, parser: ->(fc) { fc.game.roster_positions }

        attr_accessor :game_key, :game_id, :name, :code, :type, :url, :season, :is_registration_over, :is_game_over,
                      :is_offseason

        # @see YahooFantasy::Resource::Base#all
        # @return [Array<YahooFantasy::Resource::Game::Game>]
        def self.all(options = {})
          super(options, &:games)
        end

        # @see YahooFantasy::Resource::Base#get
        # @return [YahooFantasy::Resource::Game::Game]
        def self.get(key, options = {})
          super(key, options, &:game)
        end
      end
    end
  end
end
