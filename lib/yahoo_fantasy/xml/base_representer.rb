# frozen_string_literal: true

require 'representable'

module YahooFantasy
  module XML
    # Base XML Representer
    #
    # Apparently we don't even need the Representable::XML::Namespace, the tests all pass without
    # having it in there, which is good, since it's kind of shady when using it anyhow.
    #
    class BaseRepresenter < Representable::Decorator
      feature Representable::XML
      # feature Representable::XML::Namespace

      # This is super crappy, but for whatever reason I can't get namespaces to work with
      # collections within Representable::Decorator(s).  The namespaces work great for
      # properties, but when using collections with as they don't seem to work.
      # remove_namespaces!

      # namespace xmlns: 'http://fantasysports.yahooapis.com/fantasy/v2/base.rng'
      # namespace_def xmlns: 'http://fantasysports.yahooapis.com/fantasy/v2/base.rng'
      # namespace_def yahoo: 'http://www.yahooapis.com/v1/base.rng'

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

      # This is super dirty, but I don't feel like going through the Representable code to
      # find out the better place to do this.  From the quick look, it would need to build the
      # node and then apply it to my own document.
      def to_xml(*_args)
        <<~XML
          <?xml version='1.0'?>
          <fantasy_content>
          #{super.gsub(/^(\s*)</, '  \1<')}
          </fantasy_content>
        XML
      end
    end
  end
end
