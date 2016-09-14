module RailsPo
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
      page_object(*args)
      super
    end

    def page
      page_object
    end

    def page_object(*args)
      return unless self.class.name.present?

      super
    end

    def extract_view_assigns(context = self)
      return view_assigns if self.respond_to?(:view_assigns)

      context.instance_variable_get(:@_assigns)
    end

    def format_namespace(path)
      path.split('/').map(&:capitalize).join('::')
    end
  end

  module ActionControllerRendererHook
    include RendererHook

    def page_object(*args)
      namespace = self.class.name.sub('Controller', '')
      template  = action_name.capitalize

      page_object_class = "::#{namespace}::#{template}PageObject"
      page_object = page_object_class.constantize rescue return

      @page = page_object.new(extract_view_assigns)
    end
  end

  module PartialRendererHook
    prepend RendererHook

    def page_object(*args)
      namespace = format_namespace(args[0].instance_variable_get(:@virtual_path))
      template  = args[1][:partial].capitalize

      page_object_class = "::#{namespace}::#{template}PageObject"
      page_object = page_object_class.constantize rescue return

      args[1][:locals][:page] = page_object.new(extract_view_assigns(args.first).merge(args[1][:locals]))
    end
  end

  module TemplateRendererHook
    prepend RendererHook

    def page_object(*args)
      context   = args[1]
      namespace = format_namespace(context[:prefixes][0...-1].join('/'))
      template  = context[:template].capitalize

      page_object_class = "::#{namespace}::#{template}PageObject"
      page_object = page_object_class.constantize rescue return

      args.first.instance_variable_set(:@page, page_object.new(extract_view_assigns(args.first)))
    end
  end
end
