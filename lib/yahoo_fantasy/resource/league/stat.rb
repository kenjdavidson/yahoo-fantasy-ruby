# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Stats (Stat Categories)
      # Available at the uri /league/{league_key}/stat_categories or /league/{league_key};out=stat_categories
      #
      # @!attribute stat_id [Numeric] the stat id
      # @!attribute enabled [Numeric] whether the league has this stat set (1) or not (0)
      # @!attribute name [String] stat name
      # @!attribute display_name [String] stat display name/abbreviation
      # @!attribute sort_order order in which Yahoo displays stats
      # @!attribute position_type [League::RosterPosition]
      # @!attribute stat_position_type [League::StatPositionType]
      #
      Stat = Struct.new(:stat_id, :enabled, :name, :display_name, :sort_order, :position_type,
                        :stat_position_types)
    end
  end
end
