# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Scoreboard subresource
      #
      # Available at the uri /league/{league_key}/scoreboard or /league/{league_key};out=scoreboard
      #
      Scoreboard = Struct.new(:week, :matchups)

      # Scoreboard Matchup
      #
      Matchup = Struct.new(:week, :week_start, :week_end, :status, :is_playoffs, :is_consolation,
                           :is_matchup_recap_available, :teams)
    end
  end
end
