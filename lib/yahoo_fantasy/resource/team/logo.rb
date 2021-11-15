# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Logo definition for  team
      Logo = Struct.new(:image_size, :url)
    end
  end
end
