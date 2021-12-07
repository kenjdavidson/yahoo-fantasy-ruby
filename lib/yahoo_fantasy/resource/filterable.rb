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
    #
    # @todo add a Filter class instead of options Hash
    #
    module Filterable
      class InvalidFilterError < StandardError; end

      def self.included(base)
        base.extend ClassMethods
      end

      # Filter ClassMethods
      module ClassMethods
        def filters
          @filters.dup
        end

        # Parses the requested filter Hash using the available filters to create a
        # filter string.
        #
        # @param requested [Hash<String,Array<String>>] requested filters
        # @return [String] semi-colon separated filter string
        def filter_string(requested = {})
          return '' if requested.empty?

          # reduce available filters provided in requested to a string
        end

        protected

        def filter(name, options = {})
          @filters ||= {}
          @filters[name] = options
        end
      end
    end
  end
end
