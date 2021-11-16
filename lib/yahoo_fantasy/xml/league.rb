# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      autoload :LeagueRepresenter, 'yahoo_fantasy/xml/league/league_representer'
      autoload :RosterPositionRepresenter, 'yahoo_fantasy/xml/league/roster_position_representer'
      autoload :StatCategoryRepresenter, 'yahoo_fantasy/xml/league/stat_category_representer'
      autoload :StatModifierRepresenter, 'yahoo_fantasy/xml/league/stat_modifier_representer'
      autoload :SettingsRepresenter, 'yahoo_fantasy/xml/league/settings_representer'
    end
  end
end
