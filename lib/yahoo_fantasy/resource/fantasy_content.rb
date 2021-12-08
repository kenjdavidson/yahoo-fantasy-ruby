# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Fantasy wrapper providing access to all data elements available from the Yahoo Fantasy API
    # All request (even exceptions) are wrapped in <fantasy-content>.
    #
    class FantasyContent
      attr_accessor :lang, :uri, :copyright, :refresh_rate, :users,
                    :games, :leagues, :teams, :players,
                    :game, :league, :team, :player

      # Errors aren't returned with <fantasy_content> but instead <yahoo:error>, to get around
      # this we can pull the :error from <description> when it exists (since it doesn't)
      # exist for normal requests
      #
      # @return [String] the error description when available
      #
      attr_accessor :error
    end
  end
end
