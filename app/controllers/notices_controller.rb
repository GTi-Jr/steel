class NoticesController < ApplicationController
  def index
    if current_user.is_admin?

    else
      @notices = Notice.all.where(user_id: current_user.id)
    end
  end

  def show
    session[:notice_id] = params[:id]
  end
end
