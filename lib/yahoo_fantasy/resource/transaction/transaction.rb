# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Transactions are available in the context of a league.
      #
      # Resource
      # https://developer.yahoo.com/fantasysports/guide/#transaction-resource
      #
      # Transaction Key Format
      # When generating transactions it's important to get the transaction key to be correct:
      #
      # @example
      #   # Completed transactions
      #   [code|id].l.[league_id].tr.[claim_id]
      #   # Waiver claims
      #   [code|id].l.[league_id].w.c.[claim_id]
      #   # Pending trades
      #   [code|id].l.[league_id].w.c.[pending_trade_id]
      #
      # Subresources
      # The following subresources are available:
      # - /meta which is the general information
      # - /players which can be accessed by `;out=players` to gather name info
      #
      # Context
      # Transactions are available in a number of contexts
      # - The transaction context is used with :get,:put,:post,:delete for performing operations
      # - The league context provides all league transactions
      # - The team context provides all a teams transactions
      #
      class Transaction < YahooFantasy::Resource::Base
        WaiverEdit = Struct.new(:transaction_key, :type, :waiver_priority, :uses_faab)

        filter :transaction_keys
        filter :type, type: String, values: %w[add drop commish trade]
        filter :team_key, type: String
        filter :type_with_team_key, type: String, values: %w[waiver pending_trade]
        filter :count, type: Integer

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

        # @return [Array<YahooFantasy::Resource::Transaction::Player]
        attr_accessor :players
      end
    end
  end
end
