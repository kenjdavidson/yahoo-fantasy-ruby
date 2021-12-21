# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      # Serialize WaiverAction to XML
      #
      # Each item is delivered by wrapping in a <transaction> instead of the class name,
      # there are also no namespaces.
      #
      class AddDropActionRepresenter < YahooFantasy::XML::BaseRepresenter
        self.representation_wrap = :transaction

        property :type
        property :faab_bid, parse_filter: Parsers::IntegerFilter
        property :player, class: YahooFantasy::Resource::Transaction::Player,
                          decorator: YahooFantasy::XML::Transaction::PlayerRepresenter,
                          skip_render: ->(represented) { represented.nil? }
        collection :players, as: :player, wrap: :players,
                             class: YahooFantasy::Resource::Transaction::Player,
                             decorator: YahooFantasy::XML::Transaction::PlayerRepresenter,
                             skip_render: ->(represented) { represented.nil? }
      end
    end
  end
end
