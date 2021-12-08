# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Player
      # Serialize/Deserialize YahooFantasy:Resource::Team::Team
      #
      class PlayerRepresenter < YahooFantasy::XML::BaseRepresenter
        remove_namespaces!

        %i[
          player_key
          status
          status_full
          injury_note
          editorial_player_key
          editorial_team_key
          editorial_team_full_name
          editorial_team_abbr
          display_position
          image_url
          position_type
          primary_position
        ].each do |attr|
          string_properties attr
        end

        %i[
          player_id uniform_number is_undroppable has_player_notes is_editable
        ].each do |attr|
          integer_properties attr
        end

        property :name, class: YahooFantasy::Resource::Player::Name do
          property :full
          property :given, as: :first
          property :surname, as: :last
          property :ascii_given, as: :ascii_first
          property :ascii_surname, as: :ascii_last
        end

        property :headshot, class: YahooFantasy::Resource::Player::Headshot do
          property :url
          property :image_size, as: :size
        end

        collection :bye_weeks, wrap: :bye_weeks, as: :week, parse_filter: Parsers::IntegerArray
        collection :eligible_positions, wrap: :eligible_positions, as: :position
      end
    end
  end
end
