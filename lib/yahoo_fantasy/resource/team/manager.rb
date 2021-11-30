# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team Manager details
      Manager = Struct.new(:manager_id, :nickname, :guid, :is_current_login, :is_commissioner, :image_url, :felo_score, :felo_tier) do
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
