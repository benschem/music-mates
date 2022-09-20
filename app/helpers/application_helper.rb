module ApplicationHelper
  def iscurrentpage?(controller)
    "text-success" if params[:controller] == controller
  end

  def islandingpage?(pages, landing)
    render "shared/navbar" unless params[:controller] == pages && params[:action] == landing
  end

  def hide_footer?
    devise_controller? || params[:action] == "landing"
  end
end
