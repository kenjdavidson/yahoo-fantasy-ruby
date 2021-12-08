# frozen_string_literal: true

module YahooFantasy
  # Provides consistent and (what I believe to be) consistent request context for the
  # Yahoo Fantasy API documented at: https://developer.yahoo.com/fantasysports/guide/
  #
  # Note that in terms of use, Resources and Collections (although documented separately)
  # should not provide that much separate logic in the grand scheme of things.  The
  # YahooFantasy::Resource#api method is left available in order to provide your own
  # custom request logic.
  #
  module Resource
    autoload :Filterable, 'yahoo_fantasy/resource/filterable'
    autoload :Subresourceable, 'yahoo_fantasy/resource/subresourceable'
    autoload :Base, 'yahoo_fantasy/resource/base'
    autoload :FantasyContent, 'yahoo_fantasy/resource/fantasy_content'
    autoload :Game, 'yahoo_fantasy/resource/game'
    autoload :League, 'yahoo_fantasy/resource/league'
    autoload :Team, 'yahoo_fantasy/resource/team'
    autoload :Player, 'yahoo_fantasy/resource/player'

    module Draft
      autoload :DraftResult, 'yahoo_fantasy/resource/draft/draft_result'
    end
  end
end
