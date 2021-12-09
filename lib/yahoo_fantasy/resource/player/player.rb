# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Player
      # Player meta data provided by the `/players` resource.
      #
      # Resource:
      # https://developer.yahoo.com/fantasysports/guide/#player-resource
      #
      # Collection:
      # https://developer.yahoo.com/fantasysports/guide/#players-collection
      #
      class Player < YahooFantasy::Resource::Base
        filter :player_keys, type: String

        filter :position, type: String

        filter :status, type: String,
                        values: %w[A FA W T K],
                        definitions: ['All Available', 'Free Agent', 'Waivers', 'Taken', 'Keeper']

        filter :search, type: String

        filter :sort, type: String, values: %w[NAME OR AR PTS],
                      definitions: ['Last,First', 'Overall Rank', 'Actual Rank', 'Points']

        filter :sort_type, type: String, values: %w[season week date]

        # Used with `sort_type=season`
        filter :sort_season, type: Number

        # Used with `sort_type=date` for baseball, basketball, and hockey
        filter :sort_date, type: String

        # Used with `sort_type=week` for Footbal
        filter :sort_week, type: Number

        # Any integer greater/equal to 0
        filter :start, type: Number

        # Any integer greater than 0
        filter :count, type: Number

        # Statistics can bet requeseted by using the `out: [:stats]` during the request
        # or calling `player.statistics`.
        #
        # @!attribute statistics
        #   @return [Array<Statistic>]
        subresource :statistics, endpoint: '/stats'

        # @return [String]
        attr_accessor :player_key

        # @return [Number]
        attr_accessor :player_id

        # @return [String]
        attr_accessor :name

        # @return [String]
        attr_accessor :status

        # @return [String]
        attr_accessor :status_full

        # @return [String]
        attr_accessor :injury_note

        # @return [String]
        attr_accessor :editorial_player_key

        # @return [String]
        attr_accessor :editorial_team_key

        # @return [String]
        attr_accessor :editorial_team_full_name

        # @return [String]
        attr_accessor :editorial_team_abbr

        # @return [Array<Number>]
        attr_accessor :bye_weeks

        # @return [Number]
        attr_accessor :uniform_number

        # @return [String]
        attr_accessor :display_position

        # @return [YahooFantasy::Resource::Player::Headshot]
        attr_accessor :headshot

        # @return [String]
        attr_accessor :image_url

        # @return [Number]
        attr_accessor :is_undroppable

        # @return [String]
        attr_accessor :position_type

        # @return [String]
        attr_accessor :primary_position

        # @return [Array<String>]
        attr_accessor :eligible_positions

        # @return [Number]
        attr_accessor :has_player_notes

        # @return [Number]
        attr_accessor :player_notes_last_timestamp

        # @return [String] the primary position of the player
        attr_accessor :selected_position

        # @return [Number]
        attr_accessor :is_editable

        # @return [PlayerStats]
        attr_accessor :player_stats

        # @return [PlayerStats]
        attr_accessor :advanced_player_stats

        def droppable?
          !is_undroppable.zero?
        end

        def player_notes?
          !has_player_notes.zero?
        end
      end
    end
  end
end
