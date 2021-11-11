# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    class League < YahooFantasy::Resource::Base
      # League Settings subresource
      # Available at the uri /league/{league_key}/settings or /league/{league_key};out=settings
      #
      Settings = Struct.new(:draft_type, :is_auction_draft, :scoring_type, :uses_playoff,
                            :has_playoff_consolation_games, :playoff_start_week, :uses_playoff_reseeding,
                            :uses_lock_eliminated_teams, :num_playoff_teams, :num_playoff_consolation_teams,
                            :has_multiweek_championship, :uses_roster_import, :waiver_type, :waiver_rule,
                            :uses_faab, :draft_time, :draft_pick_time, :post_draft_players, :max_teams,
                            :waiver_time, :trade_end_date, :trade_ratify_type, :trade_reject_time, :player_pool,
                            :cant_cut_list, :draft_together, :can_trade_draft_picks, :sendbird_channel_url,
                            :max_weekly_adds, :pickem_enabled, :uses_fractional_points, :uses_negative_points,
                            :roster_import_deadline, :roster_positions, :stat_categories, :stat_modifiers)
    end
  end
end
