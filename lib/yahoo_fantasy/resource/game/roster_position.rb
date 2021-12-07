# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Roster positions available in a game
      #
      # @!attribute
      #   @return [String] position the roster position name
      # @!attribute abbreviation 
      #   @return [String] the roster position abbreviation
      # @!attribute display_name 
      #   @return [String] the full display name
      # @!attribute position_type
      #   @return [String] the position type which this roster position is associated
      #
      RosterPosition = Struct.new(:position, :abbreviation, :display_name, :position_type)
    end
  end
end
