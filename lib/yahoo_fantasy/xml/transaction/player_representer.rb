# frozen_string_literal: true

module YahooFantasy
  module XML
    module Transaction
      class PlayerRepresenter < YahooFantasy::XML::BaseRepresenter
        property :player_key

        property :name, class: YahooFantasy::Resource::Player::Name do
          property :full
          property :first
          property :last
          property :ascii_first
          property :ascii_last
        end

        property :data, as: :transaction_data,
                        class: YahooFantasy::Resource::Transaction::Data,
                        decorator: YahooFantasy::XML::Transaction::DataRepresenter
      end
    end
  end
end
