# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      # Serialize TradeAction to XML
      #
      # Each item is delivered by wrapping in a <transaction> instead of the class name,
      # there are also no namespaces.
      #
      class TradeActionRepresenter < YahooFantasy::XML::BaseRepresenter
        self.representation_wrap = :transaction

        property :transaction_key
        property :type
        property :action
        property :trade_note, skip_render: ->(represented) { represented.nil? }
      end
    end
  end
end
