# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team Points
      # Yahoo points are provided based on coverage_type 'week' or 'date' and provide
      # the total.  Team points are available for both actual and projections.
      Points = Struct.new(:coverage_type, :week, :date, :total)
    end
  end
end
