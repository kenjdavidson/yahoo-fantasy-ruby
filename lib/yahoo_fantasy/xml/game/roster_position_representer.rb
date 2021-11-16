# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Game
      class RosterPositionRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :position, :abbreviation, :display_name, :position_type
      end
    end
  end
end
