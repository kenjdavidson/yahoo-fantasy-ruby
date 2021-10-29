module YahooFantasy
  module Resource 
    module Filters
      class InvalidFilterError < StandardError; end

      def self.included(base)         
        base.extend ClassMethods
      end 

      module ClassMethods       
        def filter(name, *options)
          filters[name] = options
        end 

        def filters 
          @filters ||= {}
        end
      end
    end 
  end
end