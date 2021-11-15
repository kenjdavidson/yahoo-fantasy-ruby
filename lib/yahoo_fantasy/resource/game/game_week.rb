# frozen_string_literal: true

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base
      # Game week definition
      #
      # @!attribute [rw] week
      #   @return [Numeric] the week number
      #
      # @!attribute [rw] display_name
      #   @return [String] the week number
      #
      # @!attribute [rw] start
      #   @return [String,Date] the start date this week
      #
      # @!attribute [rw] end
      #   @return [String,Date] the end date of this week
      GameWeek = Struct.new(:week, :display_name, :start, :end)
    end
  end
end
