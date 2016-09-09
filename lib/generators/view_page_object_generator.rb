class ViewPageObjectGenerator < Rails::Generators::Base
  def create_initializer_file
    initializer 'view_page_object.rb' do
      'ActionController::Base.prepend ViewPageObject::RendererHook

module ApplicationHelper
  def page
    @page
  end
end'
    end

    application "config.paths.add 'page_objects', eager_load: true"
  end
end
