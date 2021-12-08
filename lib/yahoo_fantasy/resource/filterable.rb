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
      #
      module ClassMethods
        # Returns a duplicate (immutable) copy of the filters.
        # @return [Hash]
        #
        def filters
          @filters ||= {}
          @filters.dup.freeze
        end

        # Builds the filter parameters, which is pretty much the same as the key string.  Basically
        # a semi-colon separated list key/value pairs of comma separated values.
        #
        # @todo flip flopping at parsing out unknown filters (but since Yahoo doesn't fail) it's safter
        #   at this poin to just leave them in there.
        #
        # @param filters [Hash{String => Array<String>}] requested filters
        # @return [String]
        #
        def filter_params(filters = {})
          return '' if filters.nil? || filters.empty?

          filter_query = filters.map { |k, v| build_parameter_string(k, v) }
                                .join
          filter_query = filter_query.to_s unless filter_query.empty?
          filter_query
        end

        # Builds the single parameter string, which includes the key and a comma
        # separated list of values.
        #
        # @param key [String]
        # @param values [Array<String>,String]
        #
        def build_parameter_string(key, values = [])
          parameter = +";#{key}="
          parameter << if values.is_a?(Array)
                         values.join(',').to_s
                       else
                         values.to_s
                       end

          parameter
        end

        # Define a custom Filter with custom options.
        #
        # At this point the options aren't used, but this sets us up for being able to implement
        # different options:
        #
        # @param name [Symbol]
        # @param options [Hash]
        # @option options [Class] type
        # @option options [Values] values
        #
        def filter(name, options = {})
          opts = options.dup
          opts[:name] = name

          @filters ||= {}
          @filters[name] = opts
        end
      end
    end
  end
end
