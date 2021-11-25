# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team definition
      class Team < Resource::Base
        subresource :stats
        subresource :standings
        subresource :roster
        subresource :draftresults
        subresource :matchups

        attr_accessor :team_key, :team_id, :name, :url, :team_logos, :waiver_priority, :number_of_moves,
                      :number_of_trades, :roster_adds, :league_scoring_type, :has_draft_grade, :draft_grade,
                      :draft_recap_url, :managers, :win_probability, :team_points, :team_projected_points
      end
    end
  end
end
