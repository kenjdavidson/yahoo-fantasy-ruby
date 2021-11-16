# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Roster positions available in a game
      #
      # @!attribute [rw] position the roster position name
      # @!attribute abbreviation the roster position abbreviation
      # @!attribute display_name the full display name
      # @!attribute position_type the position type which this roster position is associated
      #
      RosterPosition = Struct.new(:position, :abbreviation, :display_name, :position_type)
    end
  end
end
