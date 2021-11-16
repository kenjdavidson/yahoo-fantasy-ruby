# frozen_string_literal: true

module YahooFantasy
  module JSON
    class BaseRepresenter < Representable::Decorator
      feature Representable::JSON
    end
  end
end
