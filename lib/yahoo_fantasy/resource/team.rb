# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      autoload :Logo, 'yahoo_fantasy/resource/team/logo'
      autoload :Manager, 'yahoo_fantasy/resource/team/manager'
      autoload :SeasonPoints, 'yahoo_fantasy/resource/team/points'
      autoload :WeekPoints, 'yahoo_fantasy/resource/team/points'
      autoload :DatePoints, 'yahoo_fantasy/resource/team/points'
      autoload :RosterAdds, 'yahoo_fantasy/resource/team/roster_adds'
      autoload :Standings, 'yahoo_fantasy/resource/team/standings'
      autoload :Roster, 'yahoo_fantasy/resource/team/roster'
      autoload :Matchup, 'yahoo_fantasy/resource/team/matchup'
      autoload :Team, 'yahoo_fantasy/resource/team/team'
    end
  end
end
