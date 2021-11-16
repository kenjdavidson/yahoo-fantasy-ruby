# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      autoload :Team, 'yahoo_fantasy/resource/team/team'
      autoload :Logo, 'yahoo_fantasy/resource/team/logo'
      autoload :Manager, 'yahoo_fantasy/resource/team/manager'
      autoload :Points, 'yahoo_fantasy/resource/team/points'
      autoload :RosterAdd, 'yahoo_fantasy/resource/team/roster_add'
      autoload :Standings, 'yahoo_fantasy/resource/team/standings'
    end
  end
end
