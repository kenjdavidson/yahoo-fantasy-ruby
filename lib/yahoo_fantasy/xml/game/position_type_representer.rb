# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Game
      class PositionTypeRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :type, :display_name
      end
    end
  end
end
