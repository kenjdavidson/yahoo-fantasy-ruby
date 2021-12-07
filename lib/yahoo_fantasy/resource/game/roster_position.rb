# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Roster positions available in a game
      #
      class RosterPosition
        attr_accessor :position, :abbreviation, :display_name, :position_type
      end
    end
  end
end
