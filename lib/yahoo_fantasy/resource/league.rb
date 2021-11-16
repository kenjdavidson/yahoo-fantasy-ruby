# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module League
      autoload :League, 'yahoo_fantasy/resource/league/league'
      autoload :Settings, 'yahoo_fantasy/resource/league/settings'
      autoload :RosterPosition, 'yahoo_fantasy/resource/league/roster_position'
      autoload :Stat, 'yahoo_fantasy/resource/league/stat'
      autoload :StatModifier, 'yahoo_fantasy/resource/league/stat_modifier'
      autoload :Scoreboard, 'yahoo_fantasy/resource/league/scoreboard'
    end
  end
end
