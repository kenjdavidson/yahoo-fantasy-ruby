# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      class StatCategoryRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :name, :display_name
        integer_properties :stat_id, :enabled, :sort_order

        collection :position_types, as: :position_type, wrap: :position_types
      end
    end
  end
end
