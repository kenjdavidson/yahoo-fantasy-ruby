# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Player
      # Name
      #
      # <first> is provided by given
      # <last> is provided by surname
      #
      # to get around Struct#first warnings
      #
      Name = Struct.new(:full, :given, :surname, :ascii_given, :ascii_surname)
    end
  end
end
