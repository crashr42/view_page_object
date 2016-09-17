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
      view_model(*args)
      super
    end

    def vm
      view_model
    end

    def view_model(*args)
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
      parts = template.split('/').map(&:capitalize)

      if parts.size == 1
        parts.unshift(namespace)
      end

      view_model_class = "::#{parts.join('::')}ViewModel"
      view_model_class.constantize
    end
  end

  module ActionControllerRendererHook
    include RendererHook

    def view_model(*args)
      namespace = self.class.name.sub('Controller', '')
      template  = action_name.capitalize

      view_model = build_view_model(namespace, template) rescue return

      @vm = view_model.new(extract_view_assigns)
    end
  end

  module PartialRendererHook
    prepend RendererHook

    def view_model(*args)
      view, context = args
      namespace     = format_namespace(@lookup_context.prefixes[0...-1].join('/'))
      template      = context[:partial]

      view_model = build_view_model(namespace, template) rescue nil

      if view_model.nil?
        view.remove_instance_variable(:@vm)
      else
        context[:locals][:vm] = view_model.new(extract_view_assigns(view).merge(context[:locals]))
      end
    end
  end

  module TemplateRendererHook
    prepend RendererHook

    def view_model(*args)
      view, context = args
      namespace     = format_namespace(@lookup_context.prefixes[0...-1].join('/'))
      template      = context[:template]

      view_model = build_view_model(namespace, template) rescue return

      view.instance_variable_set(:@vm, view_model.new(extract_view_assigns(view)))
    end
  end
end
