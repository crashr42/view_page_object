module RailsViewModel
  class InstallGenerator < Rails::Generators::Base
    def create_initializer_file
      initializer 'rails_view_model.rb' do
'ActionController::Base.prepend RailsViewModel::ActionControllerRendererHook
ActionView::TemplateRenderer.prepend RailsViewModel::TemplateRendererHook
ActionView::PartialRenderer.prepend RailsViewModel::PartialRendererHook

module ApplicationHelper
  def vm
    @vm
  end
end
'
      end

      application "config.paths.add 'views_models', eager_load: true"

      create_file 'app/views_models/.gitkeep'
    end
  end
end
