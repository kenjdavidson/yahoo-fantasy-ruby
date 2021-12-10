# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      class DataRepresenter < YahooFantasy::XML::BaseRepresenter
        property :type
        property :source_type
        property :source_team_key
        property :destination_type
        property :destination_team_key
      end
    end
  end
end
