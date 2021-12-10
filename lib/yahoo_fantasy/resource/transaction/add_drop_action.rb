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
      class AddDropAction
        class << self
          %w[add drop add_drop].each do |type|
            define_method(type) do |options = {}, &block|
              AddDropAction.new(type, options, &block)
            end
          end
        end

        # @return [String] should be one of add|drop|add/drop
        attr_reader :type

        # @return [Integer] optional faab bid for placing waiver claims
        attr_reader :faab_bid

        # Transaction player should contain simple {Transaction::Data} containing
        # the type `add|drop` based on the primary type as well as the source (drop)
        # or destination (add) team key.
        #
        # @return [Transaction::Player]
        attr_reader :player

        # A transaction could involve multiple players (add/drop) in which case the player
        # attribute shoudl be ignored.
        attr_reader :players

        # Create a new request
        #
        # @param type [String] should be `add|drop`
        # @param player [Transaction::Player] the player to be added along with appropriate
        #   {Transaction::Data}
        # @param players [Array<Transaction::Player>] the players to be add/drop(ed) along with the
        #   appropriate {Transaction::Data}
        # @yield [self] if a block is provided
        # @raise StandardError if add|drop and no player is provided
        # @raise StandardError if add/drop and no players are provided
        #
        def initialize(type, options = {})
          raise 'player add|drop actions' if %w[add drop].any?(type) && !options.key?(:player)
          raise 'players are required for add/drop action' if 'add/drop'.eql?(type) && !options.contains?(:players)

          @type = type
          @faab_bid = options[:faab]
          @player = options[:player] if %w[add drop].any?(type)
          @players = options[:players] if 'add/drop'.eql?(type)

          instance_eval(&block) if block_given?
        end
      end
    end
  end
end
