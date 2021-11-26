# frozen_string_literal: true

module YahooFantasy
  module Resource
    # Provides standard mixin functionality for subresources.  All resources and collections within the
    # Yahoo Fantasy API space allows for zero or more subresources.
    #
    # The only benefit I see from pulling this out of the Resource::Base is file size.  The fact that
    # any `included Subresource` class needs to either extend Resource::Base or have it's own `api`
    # method makes this a little confusing in the grand scheme of things.
    #
    # @todo look into how this case is handled, where methods are required or assumed inside the
    #   including class.  I'm starting to think that the SubResource is the way to go - and that each
    #   sub resource should be defined with the name, verb, request proc, parse proc, etc.  This seems
    #   more logical with no dependency leakage.
    #
    # Eventually this module should solely be used for:
    # - maintaing the list of subresources
    # - generating the attr_accessor and accessor! methods
    #
    module Subresourceable
      # Defines a Subresource
      #
      # At this point I don't know how big a fan I am of `Subresourceable` just trusting that there are
      # methods on the including class (`Base.resource_path` for example).  Since we can't apply abstract
      # or interface methods in Ruby, is this a thing?  Or would it be better to incldue the
      # `resource_prefix` within the Subresource so that it is required?
      #
      class Subresource
        attr_reader :name, :verb, :endpoint, :filters, :parser

        def initialize(name, options = {})
          @name = name
          @verb = options[:verb] || :get
          @endpoint = options[:endpoint] || "/#{name.downcase}"
          @filters = options[:filters] || []
          @parser = options[:parser] || ->(fantasy_content) { fantasy_content }
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      # Subresources class methods
      module ClassMethods
        # @return [Array] the available subresources
        def subresources
          @subresources.dup
        end

        protected

        # Applies a new subresource, which performs the following:
        # - adds the provided Subresource to the available @subresources
        # - adds the appropriate subresource attribute writer
        # - generates the appropriate subresource attribute reader
        #
        # @param name [Symbol] name of the subresource
        # @param options [hash]
        # @option verb [Symbol] http verb for resource - defaults to :get
        # @option endpoint [String] resource endpoint will be appended to parent resource
        # @option parser [Proc, Lambda] used to pull data from FantasyContent
        #
        def subresource(name, options = {})
          @subresources ||= {}
          @subresources[name] = Subresource.new(name, options.dup)

          define_subresource_methods @subresources[name]
        end

        def define_subresource_methods(subresource)
          attr_accessor subresource.name

          # @!method subresource!
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            define_method "#{subresource.name}!" do |filters = {}|
              path = [subresource_path(subresource), subresource_filters(subresource, filters)].join
              subresource_value = self.class.api(subresource.verb, path) do |fc|
                subresource.parser.call(fc)
              end

              instance_variable_set "@#{subresource.name}", subresource_value
              subresource_value
            end
          CODE
        end
      end

      # Joins the current resource path with the Base#resource_prefix
      #
      # @param subresource [Subresource] definition of the subresource
      #
      def subresource_path(subresource)
        [resource_path, subresource.endpoint].join
      end

      # Filters are processed into a semi-colon separated string of comma separated values
      # with `;filter_name=value1,value2,etc`.
      #
      # @param subresource [Subresource] definition of the subresource
      # @param filters [Hash{String => String,Array<String>}] hash of filters and their values
      def subresource_filters(subresource, filters = {})
        return '' if filters.empty?

        filter_string = filters.select { |k| subresource.filters.key?(k) }
                               .map { |k, v| "#{k}=#{[v].join(',')}" }
                               .join(';')
        filter_string = ";#{filter_string}" unless filter_string.empty?
        filter_string
      end
    end
  end
end
