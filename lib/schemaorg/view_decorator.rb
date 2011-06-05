module SchemaOrg

  module ViewDecorator 
  
    def micro(model, &block)
      meta = MetaModel.new(model, self)
      ret = "<span class='meta' itemscope itemtype='#{model.schema_location}'>"
      ret << capture(meta, &block)
      ret << "</span>"
      raw ret
    end
  
    def decorate(content, attr_name)

      case content
        when DateTime, Time
          decoratorfn = lambda do |formatted_content|
            content = content.to_time if content.class == DateTime
            ret = "<time itemprop='#{attr_name}' datetime='#{content.strftime('%F')}'>"
            ret << formatted_content
            ret << "</time>"
            ret
          end
          
        else
          decoratorfn = lambda do |formatted_content|
            ret = "<span class='meta' itemprop='#{attr_name}'>"
            ret << h(formatted_content)
            ret << "</span>"
          end
      end
      
      SchemaOrg::Output.new(content, &decoratorfn)

    end    
    
  end

end