ActionController::Base.prepend RailsPo::ActionControllerRendererHook
ActionView::TemplateRenderer.prepend RailsPo::TemplateRendererHook
ActionView::PartialRenderer.prepend RailsPo::PartialRendererHook

module ApplicationHelper
  def page
    @page
  end
end
