# frozen_string_literal: true

module YahooFantasy
  module Resource
    module User
      class Profile
        attr_accessor :display_name, :fantasy_profile_url, :image_url, :unique_username
      end

      # The User resource/collection is only allowed with `use_login=1` context.  Not sure when this started
      # but you cannot lookup any specific user profiles.  Anything else will result in a 403 Forbidden Access
      # error.
      #
      # The only available subresource is the `/games`.
      #
      class User < YahooFantasy::Resource::Base
        subresource :profile, parser: ->(fc) { fc.users[0]&.profile }
        subresource :games, parser: ->(fc) { fc.users[0]&.games }

        attr_accessor :guid, :profile

        # @see YahooFantasy::Resource::Base#get
        # @return [Array<YahooFantasy::Resource::User::User>]
        def self.all(options = {})
          super(options, &:users)
        end

        # @see YahooFantasy::Resource::Base#get
        # @return [YahooFantasy::Resource::User::User]
        def self.get(key, options = {})
          super(key, options, &:users[0])
        end

        # Override the {Base#collection_path} to hardwire the use_login parameter.
        def self.collection_path
          '/users;use_login=1'
        end

        # The users resource overides the {Base#resource_path} to match the {#collection_path}
        # as there isn't really a resource.
        def self.resource_path
          '/users;use_login=1'
        end
      end
    end
  end
end
