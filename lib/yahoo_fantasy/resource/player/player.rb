# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Player
      # Player meta data provided by the `/players` resource.
      #
      # @!attribute player_key
      #   @return [String]
      class Player < YahooFantasy::Resource::Base
        attr_accessor :player_key,
                      :player_id,
                      :name,
                      :status,
                      :status_full,
                      :injury_note,
                      :editorial_player_key,
                      :editorial_team_key,
                      :editorial_team_full_name,
                      :editorial_team_abbr,
                      :bye_weeks,
                      :uniform_number,
                      :display_position,
                      :headshot,
                      :image_url,
                      :is_undroppable,
                      :position_type,
                      :primary_position,
                      :eligible_positions,
                      :has_player_notes,
                      :player_notes_last_timestamp,
                      # @return [String] the primary position of the player
                      :selected_position

        # @return [Number]
        attr_accessor :is_editable

        def droppable?
          is_undroppable.zero?
        end
      end
    end
  end
end
