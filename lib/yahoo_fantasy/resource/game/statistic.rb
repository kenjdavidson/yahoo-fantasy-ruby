# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Statistic associated to the game.  Stats are related to specific position
      # types.
      #
      # @!attribute stat_id the statistic id
      # @!attribute name the statistic name
      # @!attribute display_name the long form display name
      # @!attribute sort_order order in which Yahoo! displays the stats
      # @!attribute position_type the Game::PositionType(s) to which this stat relates
      #
      Statistic = Struct.new(:stat_id, :name, :display_name, :sort_order, :position_types)
    end
  end
end
