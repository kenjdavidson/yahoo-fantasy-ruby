module YahooFantasy
  module XML
    class UserRepresenter < Representable::Decorator
      include Representable::XML

      property :guid
      property :profile, 
        decorator: YahooFantasy::XML::UserRepresenter, 
        class: YahooFantasy::Resource::User
  end 
end 