# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      class RosterPositionRepresenter < YahooFantasy::XML::BaseRepresenter
        property :position
        property :position_type
        property :count, parse_filter: Parsers::IntegerFilter
        property :is_starting_position, parse_filter: Parsers::IntegerFilter
      end
    end
  end
end
