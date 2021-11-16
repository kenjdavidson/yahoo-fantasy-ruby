# frozen_string_literal: true

module YahooFantasy
  module XML
    module Game
      autoload :GameRepresenter, 'yahoo_fantasy/xml/game/game_representer'
      autoload :GameWeekRepresenter, 'yahoo_fantasy/xml/game/game_week_representer'
      autoload :PositionTypeRepresenter, 'yahoo_fantasy/xml/game/position_type_representer'
      autoload :RosterPositionRepresenter, 'yahoo_fantasy/xml/game/roster_position_representer'
      autoload :StatCategoryRepresenter, 'yahoo_fantasy/xml/game/stat_category_representer'
    end
  end
end
