module ViewPageObject
  module Base
    include ActionView::Helpers

    def initialize(variables)
      variables.each do |variable_name, variable_value|
        instance_variable_set('@' + variable_name.to_s, variable_value)
      end
    end
  end

  module RendererHook
    extend ActiveSupport::Concern

    def render(*args)
      page_object_class = "::#{self.class.name.sub('Controller', '')}::#{action_name.capitalize}PageObject"
      page_object = page_object_class.constantize rescue nil
      unless page_object.nil?
        @page = page_object.new(view_assigns)
      end
      super
    end
  end
end
