# frozen_string_literal: true

module YahooFantasy
  module Resource
    class League
      # League Stats (Stat Categories)
      # Available at the uri /league/{league_key}/stat_categories or /league/{league_key};out=stat_categories
      #
      # @!attribute [rw] stat_id
      #   @return [Numeric] the stat id
      #
      # @!attribute [rw] enabled
      #   @return [Numeric] whether the league has this stat set (1) or not (0)
      #
      # @!attribute [rw] name
      #   @return [String] stat name
      #
      # @!attribute [rw] display_name
      #   @return [String] stat display name/abbreviation
      #
      # @!attribute [rw] sort_order
      #   @return [Numeric] order in which Yahoo displays stats
      #
      # @!attribute [rw] position_type
      #   @return [League::RosterPosition]
      #
      # @!attribute [rw] stat_position_type
      #   @return [League::StatPositionType]
      #
      Stat = Struct.new(:stat_id, :enabled, :name, :display_name, :sort_order, :position_type,
                        :stat_position_types)
    end
  end
end
