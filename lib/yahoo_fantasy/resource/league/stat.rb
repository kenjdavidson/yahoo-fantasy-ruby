# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    class League < YahooFantasy::Resource::Base
      # League Stats Position Type
      # Each statistic will have their own position type - this is used to display the position type for which this
      # position is active and whether it's a display only stat. For example the Team Defense Points For is a display
      # only stat due to it being a range
      #
      StatPositionType = Struct.new(:position_type, :is_only_display_stat)

      # League Stats (Stat Categories)
      # Available at the uri /league/{league_key}/stat_categories or /league/{league_key};out=stat_categories
      #
      Stat = Struct.new(:stat_id, :enabled, :name, :display_name, :sort_order, :position_type,
                        :stat_position_types)
    end
  end
end
