# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Stats Position Type
      # Each statistic will have their own position type - this is used to display the position type for which this
      # position is active and whether it's a display only stat. For example the Team Defense Points For is a display
      # only stat due to it being a range
      #
      StatPositionType = Struct.new(:position_type, :is_only_display_stat)
    end
  end
end
