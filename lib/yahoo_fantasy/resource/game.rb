# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      autoload :Game, 'yahoo_fantasy/resource/game/game'
      autoload :GameWeek, 'yahoo_fantasy/resource/game/game_week'
      autoload :PositionType, 'yahoo_fantasy/resource/game/position_type'
      autoload :Statistic, 'yahoo_fantasy/resource/game/statistic'
      autoload :RosterPosition, 'yahoo_fantasy/resource/game/roster_position'
    end
  end
end
