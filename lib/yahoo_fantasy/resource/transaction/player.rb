# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # At this point I'm not sure whether the transaction player should have all the API functionality
      # as the Player::Player (so it's not extending it at this point).  I really need to look at
      # separating the resource entities and the Resource/Collection functionality.
      #
      # @!attribute player_key
      #   @return [String]
      # @!attribute player_id
      #   @return [String]
      # @!attribute name
      #   @return [YahooFantasy::Resource::Player::Name]
      # @!attribute transaction_data
      #   @return [YahooFantasy::Resource::Transaction::Data]
      #
      class Player
        attr_accessor :player_key, :player_id, :name, :transaction_data
      end
    end
  end
end
