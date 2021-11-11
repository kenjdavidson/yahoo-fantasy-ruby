# frozen_string_literal: true

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base
      PositionType = Struct.new(:type, :display_name)
    end
  end
end
