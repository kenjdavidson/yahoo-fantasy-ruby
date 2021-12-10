# frozen_string_literal: true

module YahooFantasy
  # XML Parsing module.
  #
  module XML
    XMLNS_NS = 'http://fantasysports.yahooapis.com/fantasy/v2/base.rng'
    YAHOO_NS = 'http://www.yahooapis.com/v1/base.rng'

    autoload :Parsers, 'yahoo_fantasy/xml/parsers'
    autoload :BaseRepresenter, 'yahoo_fantasy/xml/base_representer'
    autoload :FantasyContentRepresenter, 'yahoo_fantasy/xml/fantasy_content_representer'
    autoload :UserRepresenter, 'yahoo_fantasy/xml/user_representer'
    autoload :ProfileRepresenter, 'yahoo_fantasy/xml/profile_representer'

    module User
      autoload :UserRepresenter, 'yahoo_fantasy/xml/user/user_representer'
    end

    module Game
      autoload :GameRepresenter, 'yahoo_fantasy/xml/game/game_representer'
      autoload :GameWeekRepresenter, 'yahoo_fantasy/xml/game/game_week_representer'
      autoload :PositionTypeRepresenter, 'yahoo_fantasy/xml/game/position_type_representer'
      autoload :RosterPositionRepresenter, 'yahoo_fantasy/xml/game/roster_position_representer'
      autoload :StatCategoryRepresenter, 'yahoo_fantasy/xml/game/stat_category_representer'
    end

    module League
      autoload :LeagueRepresenter, 'yahoo_fantasy/xml/league/league_representer'
      autoload :RosterPositionRepresenter, 'yahoo_fantasy/xml/league/roster_position_representer'
      autoload :StatCategoryRepresenter, 'yahoo_fantasy/xml/league/stat_category_representer'
      autoload :StatModifierRepresenter, 'yahoo_fantasy/xml/league/stat_modifier_representer'
      autoload :SettingsRepresenter, 'yahoo_fantasy/xml/league/settings_representer'
    end

    module Team
      autoload :TeamRepresenter, 'yahoo_fantasy/xml/team/team_representer'
    end

    module Player
      autoload :PlayerStatsRepresenter, 'yahoo_fantasy/xml/player/player_stats_representer'
      autoload :PlayerRepresenter, 'yahoo_fantasy/xml/player/player_representer'
    end

    module Draft
      autoload :DraftResultRepresenter, 'yahoo_fantasy/xml/draft/draft_result_representer'
    end

    module Transaction
      autoload :TransactionRepresenter, 'yahoo_fantasy/xml/transaction/transaction_representer'
      autoload :TradeActionRepresenter, 'yahoo_fantasy/xml/transaction/trade_action_representer'
    end
  end
end
