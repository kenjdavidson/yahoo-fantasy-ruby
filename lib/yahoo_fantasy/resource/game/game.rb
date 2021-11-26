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
        filter :is_available
        filter :game_types
        filter :game_codes
        filter :seasons

        subresource :leagues, filters: YahooFantasy::Resource::League::League.filters,
                              parser: ->(fc) { fc.game.leagues }
        subresource :game_weeks, parser: ->(fc) { fc.game.game_weeks }
        subresource :stat_categories, parser: ->(fc) { fc.game.stats }
        subresource :position_types, parser: ->(fc) { fc.game.position_types }
        subresource :roster_positions, parser: ->(fc) { fc.game.roster_positions }

        attr_accessor :game_key, :game_id, :name, :code, :type, :url, :season, :is_registration_over, :is_game_over,
                      :is_offseason

        def self.all(keys, options = {})
          super(keys, options, &:games)
        end

        def self.get(key, options = {})
          super(key, options, &:game)
        end

        def resource_path
          "/game/#{game_key}"
        end
      end
    end
  end
end
