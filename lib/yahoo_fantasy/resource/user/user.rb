# frozen_string_literal: true

module YahooFantasy
  module Resource
    module User
      class Profile
      end

      # The User resource/collection is only allowed with `use_login=1` context.  Not sure when this started
      # but you cannot lookup any specific user profiles.  Anything else will result in a 403 Forbidden Access
      # error.
      #
      # The only available subresource is the `/games`.
      #
      class User < YahooFantasy::Resource::Base
        subresource :profile, parser: ->(fc) { fc&.users[0]&.profile }
        subresource :games, parser: ->(fc) { fc&.users[0]&.games }

        attr_accessor :guid, :profile

        # @override providing the static `/users/use_login=1` path
        def self.collection_path
          '/users/use_login=1'
        end
      end
    end
  end
end
