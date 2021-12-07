# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Stats (Stat Categories)
      # Available at the uri /league/league_key/stat_categories or /league/league_key;out=stat_categories
      #
      Stat = Struct.new(:stat_id, :enabled, :name, :display_name, :sort_order, :position_type,
                        :stat_position_types)
    end
  end
end
