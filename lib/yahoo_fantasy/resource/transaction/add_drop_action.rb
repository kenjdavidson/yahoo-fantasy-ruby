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
            define_method(type) do |team_key, player_key, &block|
              AddDropAction.new(type, team_key,
                                player_key: player_key,
                                &block)
            end
          end

          %w[add_drop].each do |type|
            define_method(type) do |team_key, add_player_key, drop_player_key, &block|
              AddDropAction.new(type.gsub('_', '/'), team_key,
                                add_player_key: add_player_key,
                                drop_player_key: drop_player_key,
                                &block)
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
        # @param type [String] should be `add|drop|add/drop`
        # @param team_key [String]
        # @param options [Hash] options for appropriate action
        # @option faab [Float]
        # @option player_key [String]
        # @option add_player_key [String]
        # @option drop_player_key [String]
        # @yield [self] if a block is provided
        #
        # @raise StandardError if add|drop and no player is provided
        # @raise StandardError if add/drop and no players are provided
        #
        def initialize(type, team_key, options = {})
          raise 'invalid action type' unless %w[add drop add/drop].any?(type)

          @type = type
          @faab_bid = options[:faab]
          @player = build_player_data(type, team_key, options[:player_key]) if %w[add drop].any?(type)
          @players = build_players_data(team_key, options[:add_player_key], options[:drop_player_key]) if 'add/drop'.eql?(type)

          instance_eval(&block) if block_given?
        end

        private

        def build_players_data(team_key, add_player_key, drop_player_key)
          [
            build_player_data('add', team_key, add_player_key),
            build_player_data('drop', team_key, drop_player_key)
          ]
        end

        def build_player_data(type, team_key, player_key)
          data = 'add'.eql?(type) ? Data.add(team_key) : Data.drop(team_key)
          Player.new(player_key).tap do |p|
            p.data = data
          end
        end
      end
    end
  end
end
