# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      # Serialize WaiverAction to XML
      #
      # Each item is delivered by wrapping in a <transaction> instead of the class name,
      # there are also no namespaces.
      #
      class WaiverActionRepresenter < YahooFantasy::XML::BaseRepresenter
        self.representation_wrap = :transaction

        property :transaction_key
        property :type
        property :waiver_priority
        property :faab_bid
      end
    end
  end
end
