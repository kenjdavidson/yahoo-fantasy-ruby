# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Provides information specific to the transaction player.
      #
      # @!attribute type
      #   @return [String]
      # @!attribute source_type defines team|waiver|freeagent
      #   @return [String]
      # @!attribute source_team_key available if source_type is team
      #   @return [String]
      # @!attribute destination_type defines team|waiver|freeagent
      #   @return [String]
      # @!attribute destination_team_key available if destination_type is team
      #   @return [String]
      #
      class Data
        attr_accessor :type, :source_type, :source_team_key, :destination_type, :destination_team_key

        class << self
          # Builds an add using the appropriate team key
          # @param team_key [String] the destination team key
          def add(team_key)
            Data.new.tap do |d|
              d.type = 'add'
              d.destination_team_key = team_key
            end
          end

          # Builds a drop using the appropriate team key
          # @param team_key [String] the source team key
          def drop(team_key)
            Data.new.tap do |d|
              d.type = 'drop'
              d.source_team_key = team_key
            end
          end
        end
      end
    end
  end
end
