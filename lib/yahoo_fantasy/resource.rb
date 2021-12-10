# frozen_string_literal: true

module YahooFantasy
  # Provides consistent and (what I believe to be) consistent request context for the
  # Yahoo Fantasy API documented at: https://developer.yahoo.com/fantasysports/guide/
  #
  # Note that in terms of use, Resources and Collections (although documented separately)
  # should not provide that much separate logic in the grand scheme of things.  The
  # YahooFantasy::Resource#api method is left available in order to provide your own
  # custom request logic.
  #
  # The currently available resources and collections are:
  # - {Resource::User::User}
  # - {Resource::Game::Game}
  # - {Resource::League::League}
  # - {Resource::Team::Team}
  # - {Resource::Player::Player}
  #
  # With some partial support for:
  # - {Resource::Transaction:Transaction}
  #
  module Resource
    autoload :Filterable, 'yahoo_fantasy/resource/filterable'
    autoload :Subresourceable, 'yahoo_fantasy/resource/subresourceable'
    autoload :Base, 'yahoo_fantasy/resource/base'
    autoload :FantasyContent, 'yahoo_fantasy/resource/fantasy_content'

    module User
      autoload :User, 'yahoo_fantasy/resource/user/user'
      autoload :Profile, 'yahoo_fantasy/resource/user/user'
    end

    module Game
      autoload :GameWeek, 'yahoo_fantasy/resource/game/game_week'
      autoload :PositionType, 'yahoo_fantasy/resource/game/position_type'
      autoload :RosterPosition, 'yahoo_fantasy/resource/game/roster_position'
      autoload :Game, 'yahoo_fantasy/resource/game/game'
    end

    module League
      autoload :Settings, 'yahoo_fantasy/resource/league/settings'
      autoload :RosterPosition, 'yahoo_fantasy/resource/league/roster_position'
      autoload :Stat, 'yahoo_fantasy/resource/league/stat'
      autoload :Scoreboard, 'yahoo_fantasy/resource/league/scoreboard'
      autoload :League, 'yahoo_fantasy/resource/league/league'
    end

    module Team
      autoload :Logo, 'yahoo_fantasy/resource/team/logo'
      autoload :Manager, 'yahoo_fantasy/resource/team/manager'
      autoload :SeasonPoints, 'yahoo_fantasy/resource/team/points'
      autoload :WeekPoints, 'yahoo_fantasy/resource/team/points'
      autoload :DatePoints, 'yahoo_fantasy/resource/team/points'
      autoload :RosterAdds, 'yahoo_fantasy/resource/team/roster_adds'
      autoload :Standings, 'yahoo_fantasy/resource/team/standings'
      autoload :Roster, 'yahoo_fantasy/resource/team/roster'
      autoload :Matchup, 'yahoo_fantasy/resource/team/matchup'
      autoload :Team, 'yahoo_fantasy/resource/team/team'
    end

    module Player
      autoload :Headshot, 'yahoo_fantasy/resource/player/headshot'
      autoload :Name, 'yahoo_fantasy/resource/player/name'
      autoload :PlayerStats, 'yahoo_fantasy/resource/player/player_stats'
      autoload :Player, 'yahoo_fantasy/resource/player/player'
    end

    module Draft
      autoload :DraftResult, 'yahoo_fantasy/resource/draft/draft_result'
    end

    module Transaction
      autoload :Data, 'yahoo_fantasy/resource/transaction/data'
      autoload :Player, 'yahoo_fantasy/resource/transaction/player'
      autoload :Transaction, 'yahoo_fantasy/resource/transaction/transaction'
      autoload :TradeAction, 'yahoo_fantasy/resource/transaction/trade_action'
      autoload :WaiverAction, 'yahoo_fantasy/resource/transaction/waiver_action'
      autoload :AddDropAction, 'yahoo_fantasy/resource/transaction/add_drop_action'
    end

    # Stat category provides context/details required for managing stats.  The stat category
    # supplies the available position types for which this stat is available.
    StatCategory = Struct.new(:stat_id, :name, :display_name, :sort_order, :position_types, :enabled)

    # Stat definition are available in multiple contexts (game, league, player, etc).
    Stat = Struct.new(:stat_id, :name, :display_name, :sort_order, :position_types)

    # Stat modifier provides a link between the Stat and the value applied to the stat.
    # Available in multiple contexts (game, league, player, etc).
    StatModifier = Struct.new(:stat_id, :value)
  end
end
