# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      class TransactionRepresenter < YahooFantasy::XML::BaseRepresenter
        string_properties :transaction_key, :type, :status, :trader_team_key, :tradee_team_key, :trade_note
        integer_properties :transaction_id, :timestamp, :trade_proposed_time

        collection :players, as: :player, wrap: :players,
                             class: YahooFantasy::Resource::Transaction::Player do
          property :player_key
          property :player_id, parse_filter: Parsers::IntegerFilter
          property :name, class: YahooFantasy::Resource::Player::Name do
            property :full
            property :first
            property :last
            property :ascii_first
            property :ascii_last
          end
          property :transaction_data, class: YahooFantasy::Resource::Transaction::Data do
            property :type
            property :source_type
            property :source_team_key
            property :destination_type
            property :destination_team_key
          end
        end
      end
    end
  end
end
