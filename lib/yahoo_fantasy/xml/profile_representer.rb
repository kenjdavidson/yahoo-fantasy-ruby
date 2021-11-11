# frozen_string_literal: true

module YahooFantasy
  module XML
    class ProfileRepresenter < YahooFantasy::XML::BaseRepresenter
      property :display_name
      property :fantasy_profile_url
      property :image_url
      property :unique_username
    end
  end
end
