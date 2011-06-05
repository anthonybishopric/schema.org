
class MetaModel
  
  #Pass a model that will be proxied. Will
  #invoke output callback on accessing attributes
  def initialize(model, view_decorator)
    @model = model
    @view_decorator = view_decorator

    @model.public_methods.each do |meth|
      (class << self; self; end).class_eval do
        define_method meth do |*args|
          #for each public method on the model, pass the output
          #of the method and the method name to the view decorator
          val = @model.send meth, *args
          
          
          if meth == :method_missing
            @view_decorator.decorate val, model.microdata_attribute_name(args[0])
          else
            @view_decorator.decorate val, model.microdata_attribute_name(meth)
          end
        end
      end
    end
  end
  
 
  
end