# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Scoreboard subresource
      #
      # Available at the uri /league/league_key/scoreboard or /league/league_key;out=scoreboard
      #
      # @!attribute week
      #   @return [Number] the current matchup week
      # @!attribute matchups
      #   @return [Array<Team::Matchup>] list of matchups for this
      #
      class Scoreboard
        attr_accessor :week, :matchups
      end
    end
  end
end
