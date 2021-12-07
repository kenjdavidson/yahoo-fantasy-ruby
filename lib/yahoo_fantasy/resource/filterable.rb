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

        protected

        # Builds the filter String, which is pretty much the same as the key string.  Basically
        # a semi-colon separated list key/value pairs of comma separated values.
        #
        # @param filters [Hash{String => Array<String>}] requested filters
        # @return [String]
        #
        def filter_params(filters = {})
          return '' if filters.empty? || self.filters.empty?

          filter_query = filters.select { |k, _v| self.filters.key?(k) }
                                .map { |k, v| build_parameter_string(k, v) }
                                .join
          filter_query = filter_query.to_s unless filter_query.empty?
          filter_query
        end

        private

        def build_parameter_string(key, values = [])
          parameter = +";#{key}="
          parameter << if values.is_a?(Array)
                         values.join(',').to_s
                       else
                         values.to_s
                       end

          parameter
        end

        def filter(name, options = {})
          @filters ||= {}
          @filters[name] = options
        end
      end
    end
  end
end
