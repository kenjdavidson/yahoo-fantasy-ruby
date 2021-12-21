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
      class TradeAction
        class << self
          %w[pending_trade].each do |req|
            define_method(req) do |trader_team_key, trader_player_key, tradee_team_key, tradee_player_key, &block|
              TradeAction.new(req, trader_team_key, trader_player_key, tradee_team_key, tradee_player_key, &block)
            end
          end
        end

        # @return [String]
        attr_reader :trader_team_key

        # @return [String]
        attr_reader :tradee_team_key

        # @return [String]
        attr_reader :type

        # @return [String] any notes to provide along with the action
        attr_accessor :trade_note

        # @return [Array<Player>] list of players with transaction data
        attr_accessor :players

        # Defines a new trade action.
        #
        # @param type [String] `pending_trade` at this point there is only one type
        # @param trader_team_key [String]
        # @param trader_player_key [String]
        # @param tradee_team_key [String]
        # @param tradee_player_key [String]
        #
        def initialize(type, trader_team_key, trader_player_key, tradee_team_key, tradee_player_key)
          @type = type
          @trader_team_key = trader_team_key
          @tradee_team_key = tradee_team_key
          @players = build_players_data(trader_player_key, tradee_player_key)
        end

        private

        def build_players_data(trader_player_key, tradee_player_key)
          [
            build_player_data(trader_player_key, trader_team_key, tradee_team_key),
            build_player_data(tradee_player_key, tradee_team_key, trader_team_key)
          ]
        end

        def build_player_data(player_key, trader_team_key, tradee_team_key)
          data = Data.trade(trader_team_key, tradee_team_key)
          Player.new(player_key).tap do |p|
            p.data = data
          end
        end
      end
    end
  end
end
