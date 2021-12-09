# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # Roster position in the context of a League
      # Refacored into League and converted to Class solely got get rid of the :count warning
      class RosterPosition
        attr_accessor :position, :position_type, :count, :is_starting_position
      end

      # Stat position type in the context of a League
      class StatPositionType
        attr_accessor :position_type, :is_only_display_stat
      end

      # StatCategory in the context of a League
      class StatCategory
        attr_accessor :stat_id, :enabled, :name, :display_name, :sort_order, :position_type, :stat_position_types, :is_only_display_stat
      end

      # League Settings subresource
      # `/league/league_key/settings` or `/league/league_key;out=settings`
      class Settings
        attr_accessor :draft_type, :is_auction_draft, :scoring_type, :uses_playoff,
                      :has_playoff_consolation_games, :playoff_start_week, :uses_playoff_reseeding,
                      :uses_lock_eliminated_teams, :num_playoff_teams, :num_playoff_consolation_teams,
                      :has_multiweek_championship, :uses_roster_import, :waiver_type, :waiver_rule,
                      :uses_faab, :draft_time, :draft_pick_time, :post_draft_players, :max_teams,
                      :waiver_time, :trade_end_date, :trade_ratify_type, :trade_reject_time, :player_pool,
                      :cant_cut_list, :draft_together, :can_trade_draft_picks, :sendbird_channel_url,
                      :max_weekly_adds, :pickem_enabled, :uses_fractional_points, :uses_negative_points,
                      :roster_import_deadline, :roster_positions, :stat_categories, :stat_modifiers
      end
    end
  end
end
