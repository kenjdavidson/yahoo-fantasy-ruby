# frozen_string_literal: true

module YahooFantasy
  module Resource
    module League
      # Transactions are available in the context of a league.
      #
      class Transaction
        filter :transaction_keys

        # @return [String]
        attr_accessor :transaction_key

        # @return [String]
        attr_accessor :transaction_id

        # @return [String] value of add|drop|add_drop|trade
        attr_accessor :type

        # @return [String]
        attr_accessor :status

        # @return [Number]
        attr_accessor :timestamp

        # @return [Array<YahooFantasy::Resource::Player::Player]
        attr_accessor :players
      end
    end
  end
end
