# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Game
      class StatCategoryRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :name, :display_name
        integer_properties :stat_id, :sort_order
        collection :position_types, as: :position_type, wrap: :position_types
      end
    end
  end
end
