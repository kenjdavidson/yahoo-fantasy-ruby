# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    # Team definition
    module Team
      autoload :Logo, 'yahoo_fantasy/resource/team/logo'
      autoload :Manager, 'yahoo_fantasy/resource/team/manager'
      autoload :Points, 'yahoo_fantasy/resource/team/points'

      # @return [String] the team key in format <game_id>.l.<league_id>.t.<team_id>
      attr_accessor :team_key

      # @return [Numberic] the team id
      attr_accessor :team_id

      # @return [String] the team name
      attr_accessor :name

      # @return [String] url to the team page.  If private this requires login/auth
      attr_accessor :url

      # @return [Array<Team::Logo>] team logo
      attr_accessor :team_logos

      # @return [Numeric]
      attr_accessor :waiver_priority

      # @return [Numeric]
      attr_accessor :number_of_moves

      # @return [Numeric]
      attr_accessor :number_of_trades

      # @return [Numeric]
      attr_accessor :roster_adds

      # @return [String] scoring type is either 'roto' or 'head'
      attr_accessor :league_scoring_type

      # @return [Numeric] boolean whether grade exists 1 or 0
      attr_accessor :has_draft_grade

      # @return [Numeric]
      attr_accessor :draft_grade

      # @return [String]
      attr_accessor :draft_recap_url

      # @return [Array<Team::Manager>]
      attr_accessor :managers

      # @return [Team::Manager]
      attr_accessor :win_probability

      # @return [Team::Points]
      attr_accessor :team_points

      # @return [Numeric]
      attr_accessor :team_projected_points
    end
  end
end
