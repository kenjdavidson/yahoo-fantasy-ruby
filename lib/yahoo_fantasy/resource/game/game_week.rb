# frozen_string_literal: true

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base
      GameWeek = Struct.new(:week, :display_name, :start, :end)
    end
  end
end
