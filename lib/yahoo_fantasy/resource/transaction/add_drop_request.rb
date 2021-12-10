# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Contains message data for performing/requesting the add or drop of a specified
      # player using the (league) transaction resource.
      #
      # @example
      #   # adding a team
      #   data = Transaction::Data.new(type: 'add', destination_team_key: 'teamkey')
      #   player = Transaction::Player.new(player_key: 'playerkey', transaction_data: data)
      #   request = Transaction::AddDropRequest('add', player)
      #
      class AddDropRequest
        # @return [String] should be one of add|drop
        attr_reader :type

        # Transaction player should contain simple {Transaction::Data} containing
        # the type `add|drop` based on the primary type as well as the source (drop)
        # or destination (add) team key.
        #
        # @return [Transaction::Player]
        attr_reader :player

        # Create a new request
        #
        # @param type [String] should be `add|drop`
        # @param player [Transaction::Player] the player to be added along with provided
        #   {Transaction::Data}
        #
        def initialize(type, player)
          @type = type
          @player = player
        end
      end
    end
  end
end
