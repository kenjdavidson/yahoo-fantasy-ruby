# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team Manager details
      #
      class Manager
        # @return [String]
        attr_accessor :manager_id

        # @return [String]
        attr_accessor :nickname

        # @return [String] the Yahoo! GUID
        attr_accessor :guid

        # @return [Number] whether this manager is the currently logged in user
        attr_accessor :is_current_login

        # @return [Number]
        attr_accessor :is_commissioner

        # @return [String]
        attr_accessor :image_url

        # @return [Number]
        attr_accessor :felo_score

        # @return [String]
        attr_accessor :felo_tier

        def current_login?
          is_current_login == 1
        end

        def commissioner?
          is_commissioner == 1
        end
      end
    end
  end
end
