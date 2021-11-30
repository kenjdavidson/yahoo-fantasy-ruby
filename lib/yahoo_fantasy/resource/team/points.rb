# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # There are a number of different types of team points that are available in different
      # contexts of the Team resource.  They are defined as
      #
      # - Season points when `coverage_type` is `season`
      # - Week points when `coverage_type` is `week`
      # - Daily points when `coverage_type` is `date`
      #
      # where the `coverage_value` is applied accordingly.

      SeasonPoints = Struct.new(:coverage_type, :season, :total)

      WeekPoints = Struct.new(:coverage_type, :week, :total)

      DatePoints = Struct.new(:coverage_type, :date, :total)
    end
  end
end
