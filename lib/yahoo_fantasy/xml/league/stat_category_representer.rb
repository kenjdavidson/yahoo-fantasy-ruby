# frozen_string_literal: true

module YahooFantasy
  module XML
    module League
      class StatCategoryRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :name, :display_name, :position_type
        integer_properties :stat_id, :enabled, :sort_order
      end
    end
  end
end
