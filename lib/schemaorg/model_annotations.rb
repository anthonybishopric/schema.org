module SchemaOrg

  # Provides methods that help map the given model class to items
  # on schema.org. 
  module ModelAnnotations
    
    def self.included(base)
      base.extend ClassMethods
    end
  
    def schema_location
      self.class.schema_location
    end
    
    def microdata_attribute_name(identifier)
      self.class.microdata_attribute_name(identifier)
    end
    
    module ClassMethods
      
      def schema_location
         "http://schema.org/#{self.class}"
      end
      
      def microdata_attribute_name(identifier)
        identifier
      end
      
      #redefines schema_location 
      def microdata_item(item_type)
      
        singleton_class.redefine_method :schema_location do
          "http://schema.org/#{item_type.to_s.capitalize}"
        end

      end
   
      def microdata_attributes(attributes)
        
        singleton_class.redefine_method :microdata_attribute_name do |identifier|
          attributes[identifier] || identifier
        end
        
      end
      
    end
    
  end
  
  
end