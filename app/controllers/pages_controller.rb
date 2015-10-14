class PagesController < ApplicationController
  layout "dashboard"

  def home
    redirect_to projects_path if current_user.present?
  end

  #usuario comum
  def dashboard
    if current_user.present? && current_user.is_admin?
      render :admin #renderiza a dashboard_admin
    elsif current_user.present?
      @projects = Project.where(user_id: current_user.id).limit(10)
    else
      redirect_to new_user_session_path
    end
  end

  #usuario admin
  def dashboard_admin
    if current_user.present? && current_user.is_admin?
      @projects = Project.where(completed: false)
    else
      redirect_to new_user_session_path
    end
  end
end
