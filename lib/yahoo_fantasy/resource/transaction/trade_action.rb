# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Handles all possible trade actions
      # - Accept
      # - Reject
      # - Allowing/Disallowing
      #
      class TradeAction
        class << self
          %w[accept reject allow disallow].each do |req|
            define_method(req) do |transaction_key, trade_note = nil|
              TradeAction.new(transaction_key, 'pending_trade', req, trade_note)
            end
          end
        end

        attr_reader :transaction_key

        # @return [String]
        attr_reader :type

        # @return [String]
        attr_reader :action

        # @return [String] any notes to provide along with the action
        attr_accessor :trade_note

        # Defines a new action
        #
        # @param transaction_key [String]
        # @param type [String] `pending_trade`
        # @param action [String] `accept|reject|allow|disallow`
        # @param trade_note [String] defaults to blank
        def initialize(transaction_key, type, action, trade_note = nil)
          @transaction_key = transaction_key
          @type = type
          @action = action
          @trade_note = trade_note.to_s unless trade_note.nil?
        end
      end
    end
  end
end
