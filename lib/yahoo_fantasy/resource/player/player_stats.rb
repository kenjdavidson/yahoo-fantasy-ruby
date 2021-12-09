# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Player
      # Player statistics provides the `stat_id` and the `value` (number of) the stat they have
      # over the provided coverage type.
      #
      class PlayerStats
        # @return [String] coverage type of season|date|week
        attr_accessor :coverage_type

        # Season available when {@coverage_type} is `season`
        # @return [Number]
        attr_accessor :season

        # Season available when {@coverage_type} is `date`
        # @return [String]
        attr_accessor :date

        # Season available when {@coverage_type} is `week`
        # @return [Number]
        attr_accessor :week

        # @return [Array<Statistic>]
        attr_accessor :stats

        # @return [String,Number] the coverage value based on the value of {@coverage_type}
        def coverage_value
          case @coverage_type
          when 'season'
            season
          when 'date'
            date
          when 'week'
            week
          end
        end
      end
    end
  end
end
