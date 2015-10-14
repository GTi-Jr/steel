class PagesController < ApplicationController
  layout "dashboard"

  def home
    redirect_to projects_path if current_user.present?
  end

  def dashboard
    if current_user.present?
      @customers = User.all
      @projects = Project.limit(10)
    else
      redirect_to new_user_session_path
    end
  end
end
