# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Provides standard mixin functionality for subresources.  All resources and collections within the
    # Yahoo Fantasy API space allows for zero or more subresources.
    #
    # Unsure at this point whether using Subresource to define methods adds much benefit over just adding
    # the small set of Subresource methods to the concrete classes
    #
    module Subresources
      def self.included(base)
        base.extend ClassMethods
      end

      # ClassMethods applied to Subresources
      #
      module ClassMethods
        def subresource(name, klass)
          subresources[name] = klass
        end

        def subresources
          @subresources ||= {}
        end
      end
    end
  end
end
