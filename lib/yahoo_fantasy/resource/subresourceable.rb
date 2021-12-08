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
    # @example
    #   class SubresourcedClass
    #     include Subresourceable
    #
    #     subresource :sub_entities, verb: :Get,
    #                                endpoint: '/subentities',
    #                                filters: [:name],
    #                                parser: ->(fc) { fc.resource.subentities }
    #   end
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
          @parser = options[:parser] || ->(fantasy_content) { fantasy_content }
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      # Subresources class methods
      module ClassMethods
        # @return [Array<Subresource>] the available subresources
        #
        def subresources
          @subresources.dup
        end

        # Applies a new subresource, which performs the following:
        # - adds the provided Subresource to the available @subresources
        # - adds the appropriate subresource attribute writer
        # - generates the appropriate subresource attribute reader
        #
        # @param name [Symbol] name of the subresource
        # @param options [hash]
        # @option verb [Symbol] http verb for resource - defaults to :get
        # @option filters [Array<Filter>] available filters for this subresource
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

          # This needs to be updated so that either `parser` or something else is called.  Mainly the one issue
          # is the `/team/stats` resource which can return two subresources that need to be parsed into two instance
          # varaibles `team_points` and `team_projected_points`.
          #
          # The only other option would be to replace the whole object with what found.  For example when you make a
          # `/team/stats` request you get back the full `Team` object anyhow, and would just need to (effectively)
          # loop through all the instance variables and set them.  This would negate the need for the
          # `parser ->(fc) { fc.team.team_points }`.
          #
          # @!method subresource!
          #
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            define_method "#{subresource.name}!" do |options = {}|
              path = [
                subresource_path(subresource),#{' '}
                self.class.filter_params(options.delete(:filters)),
                self.class.out_params(options.delete(:out))
              ].join
              subresource_value = self.class.api(subresource.verb, path) do |fc|
                subresource.parser.call(fc)
              end

              instance_variable_set "@#{subresource.name}", subresource_value
              subresource_value
            end
          CODE
        end

        # Out params are much like filters (I actually flip flop between keeping them in)
        # but in the end I'd like to end up having the out parameters allow for the last
        # to be Hash and provide out parameters for that.
        #
        # @param out [Array<String,Hash>] outable resources
        #
        def out_params(out = [])
          return '' if out.nil? || out.empty?

          ";out=#{out.is_a?(Array) ? out.join(',') : out.to_s}"
        end
      end

      # Joins the current resource path with the {Base#resource_prefix}.
      #
      # @param subresource [Subresource] definition of the subresource
      #
      def subresource_path(subresource)
        [resource_path, subresource.endpoint].join
      end
    end
  end
end
