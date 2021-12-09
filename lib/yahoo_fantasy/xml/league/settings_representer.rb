# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      class SettingsRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :draft_type, :scoring_type, :roster_import_deadline, :waiver_type, :waiver_rule,
                          :post_draft_players, :trade_end_date, :trade_ratify_type, :player_pool, :cant_cut_list,
                          :sendbird_channel_url
        integer_properties :is_auction_draft, :uses_playoff, :has_playoff_consolation_games, :playoff_start_week,
                           :uses_playoff_reseeding, :uses_lock_eliminated_teams, :num_playoff_teams,
                           :num_playoff_consolation_teams, :has_multiweek_championship, :uses_roster_import,
                           :uses_faab, :draft_time, :draft_pick_time, :max_teams, :waiver_time, :trade_reject_time,
                           :draft_together, :can_trade_draft_picks, :uses_fractional_points, :uses_negative_points,
                           :pickem_enabled, :max_weekly_adds

        collection :roster_positions, as: :roster_position, wrap: :roster_positions,
                                      class: YahooFantasy::Resource::League::RosterPosition do
          property :position
          property :position_type
          property :count, parse_filter: Parsers::IntegerFilter
          property :is_starting_position, parse_filter: Parsers::IntegerFilter
        end

        collection :stat_categories, as: :stat, wrap: 'stat_categories/stats',
                                     class: YahooFantasy::Resource::League::StatCategory do
          property :stat_id, parse_filter: Parsers::IntegerFilter
          property :enabled, parse_filter: Parsers::IntegerFilter
          property :name
          property :display_name
          property :sort_order, parse_filter: Parsers::IntegerFilter
          property :position_type
          property :is_only_display_stat, parse_filter: Parsers::IntegerFilter
          collection :stat_position_types, as: :stat_position_type, wrap: :stat_position_types,
                                           class: YahooFantasy::Resource::League::StatPositionType do
            property :position_type
            property :is_only_display_stat
          end
        end

        collection :stat_modifiers, as: :stat, wrap: 'stat_modifiers/stats',
                                    class: YahooFantasy::Resource::StatModifier,
                                    decorator: League::StatModifierRepresenter
      end
    end
  end
end
