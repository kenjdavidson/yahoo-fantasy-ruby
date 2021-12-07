# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Roster and Player list.
      #
      class Roster
        attr_accessor :coverage_type, :week, :is_editable, :players

        def editable?
          is_editable == 1
        end
      end
    end
  end
end
