# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Handles player and commissioner trade actions:
      #
      # Accepting/Rejecting:
      # Once you have the transaction_key for a pending trade that has been proposed to you, which you can
      # get by asking the transactions collection for all pending trades for your team, you can choose to
      # accept or reject it.
      #
      # Allowing/Disallowing:
      # If there are accepted trades in your league waiting to be processed, which you can get by asking the
      # transactions collection for all pending trades for your team, and you’re the commissioner of a league
      # that has the commissioner approve trades, you can choose to allow or disallow the trade.
      #
      # Deleting:
      # No action is require for a delete, as it uses the HTTP verb :delete against the transaction resource
      class TradeVoteAction
        class << self
          %w[accept reject allow disallow vote_against].each do |req|
            define_method(req) do |transaction_key, trade_note: nil, voter_team_key: nil|
              TradeVoteAction.new(transaction_key, 'pending_trade', req, trade_note: trade_note, voter_team_key: voter_team_key)
            end
          end
        end

        # @return [String]
        attr_reader :transaction_key

        # @return [String]
        attr_reader :type

        # @return [String]
        attr_reader :action

        # @return [String] any notes to provide along with the action
        attr_accessor :trade_note

        # Defines a new trade action.
        #
        # @param transaction_key [String]
        # @param type [String] `pending_trade`
        # @param action [String] `accept|reject|allow|disallow`
        # @param trade_note [String] defaults to blank
        # @param voter_team_key [String] the team key required for against votes.
        # @raise StandardError if no voter_team_key provided for vote against
        def initialize(transaction_key, type, action, trade_note: nil, voter_team_key: nil)
          raise 'Voter team key is required for voting against trade' if action.eql?('vote_against') && voter_team_key.nil?

          @transaction_key = transaction_key
          @type = type
          @action = action
          @trade_note = trade_note.to_s unless trade_note.nil?
          @voter_team_key = voter_team_key.to_s unless voter_team_key.nil?
        end
      end
    end
  end
end
