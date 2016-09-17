ActionController::Base.prepend RailsViewModel::ActionControllerRendererHook
ActionView::TemplateRenderer.prepend RailsViewModel::TemplateRendererHook
ActionView::PartialRenderer.prepend RailsViewModel::PartialRendererHook

module ApplicationHelper
  def vm
    @vm
  end
end
