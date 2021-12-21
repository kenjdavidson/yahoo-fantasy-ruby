# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      # Serialize WaiverAction to XML
      #
      # Each item is delivered by wrapping in a <transaction> instead of the class name,
      # there are also no namespaces.
      #
      class TradeActionRepresenter < YahooFantasy::XML::BaseRepresenter
        self.representation_wrap = :transaction

        property :type
        property :trader_team_key
        property :tradee_team_key
        property :trade_note

        collection :players, as: :player, wrap: :players,
                             class: YahooFantasy::Resource::Transaction::Player,
                             decorator: YahooFantasy::XML::Transaction::PlayerRepresenter
      end
    end
  end
end
