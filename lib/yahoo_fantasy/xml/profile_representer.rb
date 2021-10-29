module YahooFantasy
  module XML
    class ProfileRepresenter < Representable::Decorator
      include Representable::XML

      property :display_name
      property :fantasy_profile_url
      property :image_url
      property :unique_username
  end 
end 