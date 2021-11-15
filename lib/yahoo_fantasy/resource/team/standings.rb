# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team Points
      # Yahoo points are provided based on coverage_type 'week' or 'date' and provide
      # the total.  Team points are available for both actual and projections.
      Standings = Struct.new(:rank, :playoff_seed, :wins, :losses, :ties, :percentage, :streak_type, :streak,
                             :points_for, :points_against)
    end
  end
end
