# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Fantasy wrapper providing access to all data elements available from the Yahoo Fantasy API
    # This could probably be a Struct or OpenStruct, but for now I'm not sure whether
    # we'll want to extend the YahooFantasy::Resource::Base for anything
    #
    class FantasyContent
      attr_accessor :lang, :uri, :copyright, :refresh_rate, :users, :games, :leagues, :game, :league

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
