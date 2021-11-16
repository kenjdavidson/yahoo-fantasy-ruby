# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Game week definition
      #
      # @!attribute week the week number
      # @!attribute display_name the week number string
      # @!attribute start [String,Date] the start date this week
      # @!attribute end [String,Date] the end date of this week
      #
      GameWeek = Struct.new(:week, :display_name, :start, :end)
    end
  end
end
