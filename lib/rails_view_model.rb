module RailsViewModel
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

    def build_view_model(namespace, template)
      view_model_class = "::#{namespace}::#{template}ViewModel"
      view_model_class.constantize
    end
  end

  module ActionControllerRendererHook
    include RendererHook

    def page_object(*args)
      namespace = self.class.name.sub('Controller', '')
      template  = action_name.capitalize

      view_model = build_view_model(namespace, template) rescue return

      @page = view_model.new(extract_view_assigns)
    end
  end

  module PartialRendererHook
    prepend RendererHook

    def page_object(*args)
      namespace = format_namespace(args[0].instance_variable_get(:@virtual_path))
      template  = args[1][:partial].capitalize

      view_model = build_view_model(namespace, template) rescue return

      args[1][:locals][:page] = view_model.new(extract_view_assigns(args.first).merge(args[1][:locals]))
    end
  end

  module TemplateRendererHook
    prepend RendererHook

    def page_object(*args)
      context   = args[1]
      namespace = format_namespace(context[:prefixes][0...-1].join('/'))
      template  = context[:template].capitalize

      view_model = build_view_model(namespace, template) rescue return

      args.first.instance_variable_set(:@page, view_model.new(extract_view_assigns(args.first)))
    end
  end
end
