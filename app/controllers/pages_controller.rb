class PagesController < ApplicationController
  layout "dashboard"

  #usuario comum
  def dashboard
    if current_user.present? && current_user.is_admin?
      redirect_to admin_url #renderiza a dashboard_admin
    elsif current_user.present?
      @projects = Project.where(user_id: current_user.id).limit(10)
    else
      redirect_to new_user_session_path
    end
  end

  #usuario admin
  def dashboard_admin
    if current_user.present? && current_user.is_admin?
      #@projects = Project.where(completed: false).order("created_at DESC")
      @projects = Project.where(["completed = :completed and canceled = :canceled",
                                { completed: false,
                                  canceled: false }]).order("created_at DESC")
                                .page(params[:page]).per_page(10)
    else
      redirect_to new_user_session_path
    end
  end
end
