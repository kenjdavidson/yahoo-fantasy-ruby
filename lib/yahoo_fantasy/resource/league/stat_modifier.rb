# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # League Stat Modifiers
      # Stat modifiers are the numerical value used as a multiplier based on the statistic value. For
      # example the default QB Passing Touchdown modifier is 4 - meaning that a QB gets 4 pts for
      # every one touchdown.
      #
      # Available at the uri /league/{league_key}/stat_modifiers or /league/{league_key};out=stat_modifiers
      #
      StatModifier = Struct.new(:stat_id, :value)
    end
  end
end
