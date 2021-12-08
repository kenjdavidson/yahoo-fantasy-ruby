# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Draft
      # (De)serializes {Draft::DraftResults}
      #
      class DraftResultRepresenter < BaseRepresenter
        %i[team_key player_key].each do |attr|
          string_properties attr
        end

        %i[pick round].each do |attr|
          integer_properties attr
        end

        collection :players, wrap: :players, as: :player,
                             decorator: YahooFantasy::XML::Player::PlayerRepresenter,
                             class: YahooFantasy::Resource::Player::Player
      end
    end
  end
end
