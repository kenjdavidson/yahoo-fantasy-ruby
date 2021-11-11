# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    class GameWeekRepresenter < YahooFantasy::XML::BaseRepresenter
      string_properties :display_name, :start, :end
      integer_properties :week
    end

    class PositionTypeRepresenter < YahooFantasy::XML::BaseRepresenter
      string_properties :type, :display_name
    end

    class RosterPositionRepresentor < YahooFantasy::XML::BaseRepresenter
      string_properties :position, :abbreviation, :display_name, :position_type
    end

    class StatCategoryRepresenter < YahooFantasy::XML::BaseRepresenter
      string_properties :name, :display_name
      integer_properties :stat_id, :sort_order
      collection :position_types, as: :position_type, wrap: :position_types
    end

    # Serialize/Deserialize YahooFantasy::Resource::Game
    #
    class GameRepresenter < YahooFantasy::XML::BaseRepresenter
      # namespace YahooFantasy::XML::XMLNS_NS
      # namespace_def xmlns: YahooFantasy::XML::XMLNS_NS
      # namespace_def yahoo: YahooFantasy::XML::YAHOO_NS
      remove_namespaces!

      string_properties :game_key, :name, :code, :type, :url
      integer_properties :game_id, :season, :is_registration_over, :is_game_over, :is_offseason

      # Leagues collection of YahoooFantasy::XML::League
      # collection :leagues, as: :league, wrap: :leagues,
      #                      class: YahooFantasy::Resource::League,
      #                      decorator: YahooFantasy::XML::LeagueRepresenter

      # Game Weeks
      collection :game_weeks, as: :game_week, wrap: :game_weeks,
                              class: YahooFantasy::Resource::Game::GameWeek,
                              decorator: GameWeekRepresenter

      # Position Types
      collection :position_types, as: :position_type, wrap: :position_types,
                                  class: YahooFantasy::Resource::Game::PositionType,
                                  decorator: PositionTypeRepresenter

      # Roster Positions
      collection :roster_positions, as: :roster_position, wrap: :roster_positions,
                                    class: YahooFantasy::Resource::Game::RosterPosition,
                                    decorator: RosterPositionRepresentor

      # Stat Categories - is wrapped in an extra level of <stat_category><stat> which
      # needs to be accounted for.
      collection :stat_categories, as: :stat, wrap: 'stat_categories/stats',
                                   class: YahooFantasy::Resource::Game::Statistic,
                                   decorator: StatCategoryRepresenter
    end
  end
end
