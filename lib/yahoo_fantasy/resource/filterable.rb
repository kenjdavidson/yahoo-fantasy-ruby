# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Provides common functionality for filterable reasources.
    #
    # At this point it doesn't really do much but provide inline code/comments for what
    # filters are available for the respective subresource.
    #
    # The end goal is provide "type checking" (solely because I haven't wrapped my head around
    # non type checking yet) and Resource request validation.  Although, at this point the
    # Yahoo Fantasy API just ignores unknown filters.
    module Filterable
      class InvalidFilterError < StandardError; end

      def self.included(base)
        base.extend ClassMethods
      end

      # Filter ClassMethods
      module ClassMethods
        def filter(name, *options)
          filters[name] = options
        end

        def filters
          @filters ||= {}
        end
      end
    end
  end
end
