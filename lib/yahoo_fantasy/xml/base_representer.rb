# frozen_string_literal: true

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

      # Define basic properties
      #
      # @param props [Array<Symbol>] property name(s)
      def self.string_properties(*props)
        props.each do |prop|
          property prop
        end
      end

      # Define properties using Integer parser
      #
      # @param props [Array<Symbol>] property name(s) to be defined as Integer
      def self.integer_properties(*props)
        props.each do |prop|
          property prop, parse_filter: XML::Parsers::IntegerFilter
        end
      end

      # Define propreties using Float Parser
      #
      # @param props [Array<Symbol>] property name(s) to be defined as Float
      def self.float_properties(*props)
        props.each do |prop|
          property prop, parse_filter: XML::Parsers::FloatFilter
        end
      end
    end
  end
end
