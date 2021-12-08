# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Draft
      # Draft results are available at both the {Team::Team} and {League::League} level.  Draft results
      # have the added output of `;out=players` which will provide an {Array} of {Player::Player} items
      # incase you haven't had them loaded separately.
      # 
      # @!attribute pick [Number] the overall pick number
      # @!attribute round [Sumber] the round in which this pick occurred
      # @!attribute team_key [String] the team key - sadly there is no `;out=teams` as well
      # @!attribute player_key [String] the player key - but use `;out=players` 
      # @!attribute players [Array<Player::Player>] the player matching player id, wrapped in an Array??
      #
      class DraftResult
        attr_accessor :pick,
                      :round,
                      :team_key,
                      :player_key,
                      :players

        # Player shortcut to get around the array
        # @return [Player::Player]
        #
        def player 
          players[0]
        end
      end
    end
  end
end
