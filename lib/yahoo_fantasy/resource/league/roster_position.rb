# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module League
      # League Roster Positions
      #
      # Available at the uri /league/league_key/roster_positions or /league/league_key;out=roster_positions
      #
      class RosterPosition
        attr_accessor :position, :position_type, :count, :is_starting_position
      end
    end
  end
end
