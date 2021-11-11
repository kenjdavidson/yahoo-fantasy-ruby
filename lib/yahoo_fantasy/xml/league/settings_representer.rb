# frozen_string_literal: true

module YahooFantasy
  module XML
    class LeagueRepresenter < YahooFantasy::XML::BaseRepresenter
      class RosterPositionRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :position, :position_type
        integer_properties :count, :is_starting_position
      end

      class StatCategoryRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :name, :display_name, :position_type
        integer_properties :stat_id, :enabled, :sort_order
      end

      class StatModifierRepresenter < YahooFantasy::XML::BaseRepresenter
        integer_properties :stat_id
        float_properties :value
      end

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
                                      class: YahooFantasy::Resource::League::RosterPosition,
                                      decorator: LeagueRepresenter::RosterPositionRepresenter

        collection :stat_categories, as: :stat, wrap: 'stat_categories/stats',
                                     class: YahooFantasy::Resource::League::Stat,
                                     decorator: LeagueRepresenter::StatCategoryRepresenter

        collection :stat_modifiers, as: :stat, wrap: 'stat_modifiers/stats',
                                    class: YahooFantasy::Resource::League::StatModifier,
                                    decorator: LeagueRepresenter::StatModifierRepresenter
      end
    end
  end
end
