# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Provides standard mixin functionality for subresources.  All resources and collections within the
    # Yahoo Fantasy API space allows for zero or more subresources.
    #
    # Unsure at this point whether using Subresource to define methods adds much benefit over just adding
    # the small set of Subresource methods to the concrete classes
    #
    module Subresourceable
      def self.included(base)
        base.extend ClassMethods
      end

      # Subresources class methods
      module ClassMethods
        # Applies a new subresource, which performs the following:
        # - adds the provided Subresource to the available @subresources
        # - adds the appropriate subresource attribute writer
        # - generates the appropriate subresource attribute reader
        #
        def subresource(name, klass)
          subresources[name] = klass

          attr_accessor name
        end

        # @return [Array] the available subresources
        def subresources
          @subresources ||= {}
        end
      end
    end
  end
end
