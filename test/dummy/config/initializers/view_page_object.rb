ActionController::Base.prepend ViewPageObject::RendererHook

module ApplicationHelper
  def page
    @page
  end
end