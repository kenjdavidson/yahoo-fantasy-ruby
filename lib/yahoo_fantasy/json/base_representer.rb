# frozen_string_literal: true

module YahooFantasy
  module XML
    class BaseRepresenter < Representable::Decorator
      feature Representable::JSON
    end
  end
end
