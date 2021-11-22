# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module League
      # League Resource (and Collection) is documented at:
      #
      # https://web.archive.org/web/20130822105844/http://developer.yahoo.com/fantasysports/guide/league-resource.html#league-resource-desc
      # https://web.archive.org/web/20130822105532/http://developer.yahoo.com/fantasysports/guide/leagues-collection.html#leagues-collection-desc
      #
      class League < YahooFantasy::Resource::Base
        filter :league_keys

        subresource :settings, Settings
        subresource :scoreboard, Scoreboard
        subresource :standings, Team::Team
        subresource :teams, Team::Team
        # subresoure :players,
        # subresource :transactions,

        attr_accessor :league_key, :league_id, :name, :url, :logo_url, :draft_status, :num_teams, :edit_key, :weekly_deadline,
                      :league_update_timestamp, :scoring_type, :league_type, :renew, :renewed, :iris_group_chat_id, :allow_add_to_dl_extra_pos,
                      :is_pro_league, :is_cash_league, :current_week, :start_week, :start_date, :end_week, :end_date, :game_code, :season

        def game_key
          league_key.split('.').first
        end

        def game_id
          league_key.split('.').first.to_i
        end
      end
    end
  end
end
