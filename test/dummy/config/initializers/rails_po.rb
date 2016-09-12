ActionController::Base.prepend RailsPo::RendererHook
ActionView::Helpers.prepend RailsPo::RendererHook

module ApplicationHelper
  def page
    @page
  end
end
