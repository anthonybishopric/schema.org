module SchemaOrg


  #allows further calls to be made on the output of a content function
  #without altering the markup generated by the view_decorator
  #
  # <%= micro @person  do |microperson|%>
  #   
  #    <%= microperson.created_at.strftime(%M/%Y) 
  #
  # <%end%>
  #
  class Output
  
    def initialize(value, &decoration)
      @decoration = decoration
      @value = value
        
    end
    
    #
    # Pretend to be the output of the function being called. This allows
    # the view layer to call formatting operations, other functions on the 
    # value
    #
    def method_missing(method, *args, &block)
      @value = @value.send method, *args, &block
      self
    end
  
    def to_s
      @decoration.call(@value).html_safe
    end
    
    def to_str
      self.to_s
    end
    
    def inspect
      self.to_s
    end
  
  end

end