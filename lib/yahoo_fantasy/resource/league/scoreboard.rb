# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # Matchups are only available in `head` (head to head) leagues, and provide information regarding a 
      # set of teams playing against each other.
      # 
      # @todo possibly move out of here, as Matchup can be associated to both league and team resources
      #
      class Matchup 
        attr_accessor :week, :week_start, :week_end, :status, :is_playoffs, :is_consolation, :is_matchup_recap_available, :teams
      end 

      # League Scoreboard subresource
      #
      # Available at the uri /league/league_key/scoreboard or /league/league_key;out=scoreboard
      # 
      # @!attribute week 
      #   @return [Number] the current matchup week
      # @!attribute matchups
      #   @return [Array<Matchup>] list of matchups for this week
      class Scoreboard 
        attr_accessor :week, :matchups
      end
    end
  end
end
