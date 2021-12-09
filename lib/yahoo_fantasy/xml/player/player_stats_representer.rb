# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Player
      class PlayerStatsRepresenter < YahooFantasy::XML::BaseRepresenter
        property :coverage_type
        property :season, parse_filter: Parsers::IntegerFilter
        property :date
        property :week, parse_filter: Parsers::IntegerFilter
        collection :stats, as: :stat, wrap: :stats,
                           class: YahooFantasy::Resource::StatModifier do
          property :stat_id, parse_filter: Parsers::IntegerFilter
          property :value, parse_filter: Parsers::FloatFilter
        end
      end
    end
  end
end
