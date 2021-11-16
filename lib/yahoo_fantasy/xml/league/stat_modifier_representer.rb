# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      class StatModifierRepresenter < YahooFantasy::XML::BaseRepresenter
        integer_properties :stat_id
        float_properties :value
      end
    end
  end
end
