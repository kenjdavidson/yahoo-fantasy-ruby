# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      # (De)serialize <transaction> xml
      #
      # @example
      #
      class TransactionRepresenter < YahooFantasy::XML::BaseRepresenter
        player_builder = ->(fragment:, **) { YahooFantasy::Resource::Transaction::Player.new(fragment > 'player_key') }

        string_properties :transaction_key, :type, :status, :trader_team_key, :tradee_team_key, :trade_note
        integer_properties :transaction_id, :timestamp, :trade_proposed_time

        collection :players, as: :player, wrap: :players,
                             instance: player_builder,
                             decorator: YahooFantasy::XML::Transaction::PlayerRepresenter
      end
    end
  end
end
