# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Game
      class GameWeekRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :display_name, :start, :end
        integer_properties :week
      end
    end
  end
end
