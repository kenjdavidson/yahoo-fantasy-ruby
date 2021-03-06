# frozen_string_literal: true

module YahooFantasy
  module XML
    module Parsers
      StringFilter = ->(fragment, _options) { fragment.to_s }
      IntegerFilter = ->(fragment, _options) { fragment.to_i }
      BooleanFilter = ->(fragment, _options) { fragment.to_b }
      FloatFilter = ->(fragment, _options) { fragment.to_f }

      IntegerArray = ->(fragment, _options) { fragment.map(&:to_i) }
    end
  end
end
