# frozen_string_literal: true

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base
      Statistic = Struct.new(:stat_id, :name, :display_name, :sort_order, :position_types)
    end
  end
end
