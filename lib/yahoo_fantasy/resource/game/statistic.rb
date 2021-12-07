# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Statistic associated to the game.  Stats are related to specific position
      # types.
      #
      class Statistic
        attr_accessor :stat_id, :name, :display_name, :sort_order, :position_types
      end
    end
  end
end
