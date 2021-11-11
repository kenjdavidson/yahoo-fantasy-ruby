# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    # League Resource (and Collection) is documented at
    # https://web.archive.org/web/20130822105844/http://developer.yahoo.com/fantasysports/guide/league-resource.html#league-resource-desc
    # https://web.archive.org/web/20130822105532/http://developer.yahoo.com/fantasysports/guide/leagues-collection.html#leagues-collection-desc
    #
    class League < YahooFantasy::Resource::Base
      autoload :Settings, 'yahoo_fantasy/resource/league/settings'
      autoload :RosterPosition, 'yahoo_fantasy/resource/league/roster_position'
      autoload :Stat, 'yahoo_fantasy/resource/league/stat'
      autoload :StatModifier, 'yahoo_fantasy/resource/league/stat_modifier'

      filter :league_keys

      attr_accessor :league_key, :league_id, :name, :url, :logo_url, :draft_status, :num_teams, :edit_key, :weekly_deadline,
                    :league_update_timestamp, :scoring_type, :league_type, :renew, :renewed, :iris_group_chat_id, :allow_add_to_dl_extra_pos,
                    :is_pro_league, :is_cash_league,
                    :current_week, :start_week, :start_date, :end_week, :end_date, :game_code, :season, :settings,
                    :standings, :scoreboard, :teams, :players, :transactions

      def self.all; end
    end
  end
end
