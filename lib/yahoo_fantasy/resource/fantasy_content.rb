# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Fantasy wrapper providing access to all data elements available from the Yahoo Fantasy API
    # This could probably be a Struct or OpenStruct, but for now I'm not sure whether
    # we'll want to extend the YahooFantasy::Resource::Base for anything
    #
    class FantasyContent
      attr_accessor :lang, :uri, :copyright, :refresh_rate, :users, :games, :leagues, :game, :league
    end
  end
end
