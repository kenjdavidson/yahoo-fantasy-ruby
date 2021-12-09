# frozen_string_literal: true

module YahooFantasy
  module XML
    module User
      # Dirty way to handle FantasyContent/user/* requests
      # Pretty much just supplies
      class UserRepresenter < YahooFantasy::XML::BaseRepresenter
        remove_namespaces!

        property :guid

        property :profile, class: YahooFantasy::Resource::User::Profile do
          property :display_name
          property :fantasy_profile_url
          property :image_url
          property :unique_username
        end

        collection :games, as: :game, wrap: :games,
                           decorator: YahooFantasy::XML::Game::GameRepresenter,
                           class: YahooFantasy::Resource::Game::Game
      end
    end
  end
end
