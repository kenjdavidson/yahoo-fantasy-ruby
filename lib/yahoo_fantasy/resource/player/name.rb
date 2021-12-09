# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Player
      # Player name
      #
      class Name
        # @return [String]
        attr_accessor :full

        # @return [String]
        attr_accessor :first

        # @return [String]
        attr_accessor :last

        # @return [String]
        attr_accessor :ascii_first

        # @return [String]
        attr_accessor :ascii_last
      end
    end
  end
end
