# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Logo definition for  team
      #
      class Logo
        # @return [String]
        attr_accessor :url

        # @return [String]
        attr_accessor :size
      end
    end
  end
end
