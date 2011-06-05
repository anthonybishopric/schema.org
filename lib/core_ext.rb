
ActionView::Base.send(:include, SchemaOrg::ViewDecorator)


ActiveRecord::Base.send(:include, SchemaOrg::ModelAnnotations)
  
