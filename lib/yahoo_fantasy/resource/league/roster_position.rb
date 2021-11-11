# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    class League < YahooFantasy::Resource::Base
      # League Roster Positions
      # Available at the uri /league/{league_key}/roster_positions or /league/{league_key};out=roster_positions
      #
      RosterPosition = Struct.new(:position, :position_type, :count, :is_starting_position)
    end
  end
end
