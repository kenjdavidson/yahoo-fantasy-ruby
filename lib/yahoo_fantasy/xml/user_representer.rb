# frozen_string_literal: true

module YahooFantasy
  module XML
    class UserRepresenter < YahooFantasy::XML::BaseRepresenter
      property  :guid
      property  :profile,
                decorator: YahooFantasy::XML::UserRepresenter,
                class: YahooFantasy::Resource::User
    end
  end
end
