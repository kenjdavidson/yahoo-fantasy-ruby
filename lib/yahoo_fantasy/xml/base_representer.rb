# frozen_string_literal: true

require 'representable'

module YahooFantasy
  module XML
    # Base XML Representer
    #
    class BaseRepresenter < Representable::Decorator
      feature Representable::XML
      feature Representable::XML::Namespace

      # This is super crappy, but for whatever reason I can't get namespaces to work with
      # collections within Representable::Decorator(s).  The namespaces work great for
      # properties, but when using collections with as they don't seem to work.
      remove_namespaces!

      class << self
        # @!method string_properties
        # @!method integer_properties
        # @!method float_properties
        # @!method boolean_properties
        {
          string: Parsers::StringFilter,
          integer: Parsers::IntegerFilter,
          float: Parsers::FloatFilter,
          boolean: Parsers::BooleanFilter
        }.each do |k, v|
          define_method "#{k}_properties" do |*props|
            props.each do |prop|
              property prop, parse_filter: v
            end
          end
        end
      end
    end
  end
end
