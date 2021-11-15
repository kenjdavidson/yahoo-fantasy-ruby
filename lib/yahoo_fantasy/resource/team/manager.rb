# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Team Manager details
      Manager = Struct.new(:manager_id, :nickname, :guid, :is_commissioner, :image_url, :felo_score, :felo_tier)
    end
  end
end
