module ApplicationHelper

  def iscurrentpage?(controller)
    "text-success" if params[:controller] == controller
  end

end
