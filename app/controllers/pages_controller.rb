class PagesController < ApplicationController
  layout "dashboard"

  # GET 
  # Página do usuario comum
  # Carrega os projetos do próprio usuário
  def dashboard
    if current_user.present? && current_user.is_admin?
      redirect_to admin_url #renderiza a dashboard_admin
    elsif current_user.present?
      @projects = current_user.projects
    else
      redirect_to new_user_session_path
    end
  end

  # GET
  # Página do usuario admin
  # Carrega os projetos ativos(Não completos e não cancelados)
  def dashboard_admin
    if current_user.present? && current_user.is_admin?
      @projects = Project.where(["completed = :completed and canceled = :canceled",
                                { completed: false,
                                  canceled: false }]).order("created_at DESC")
                                .page(params[:page]).per_page(10)
    else
      redirect_to new_user_session_path
    end
  end
end
