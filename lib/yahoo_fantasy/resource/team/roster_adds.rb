# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # RosterAdds
      #
      # @!attribute coverage_type
      #   @return [String] the coverage type 'week' or 'date'
      # @!attribute coverage_value
      #   @return [Numeric] the week or date dependant on type
      # @!attribute value
      #   @return [Numeric] the number of adds within the coverage type
      RosterAdds = Struct.new(:coverage_type, :coverage_value, :value) do
        # @return [Integer,Date] coverage value based on the type.  `week` (nfl) will
        #   return an integer, while `date` (nhl,mlb) will return a date
        #
        # def coverage_value
        #   coverage_type == 'week' ? @coverage_value.to_i : Date.parse(@coverage_value)
        # end
      end
    end
  end
end
