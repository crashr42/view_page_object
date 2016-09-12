ActionController::Base.prepend RailsPo::RendererHook

module ApplicationHelper
  def page
    @page
  end
end