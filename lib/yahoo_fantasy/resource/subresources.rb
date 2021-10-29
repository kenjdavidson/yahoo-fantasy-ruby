module YahooFantasy
  module Resource 
    module Subresources    
      def self.included(base) 
        base.extend ClassMethods
      end 

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