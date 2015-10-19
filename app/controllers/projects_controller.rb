class ProjectsController < ApplicationController
  layout "dashboard"
  before_action :load_project, only: [:show, :edit, :update, :destroy, :complete, :uncomplete]

  def index
    if current_user.is_admin?
      @projects = Project.order("created_at DESC")
    else
      @projects = Project.where(user_id: current_user.id)
    end  
  end

  def show
    session[:project_id] = params[:id]
    @notices = @project.notices.order("created_at DESC")
  end

  def new
    @project = Project.new if current_user.is_admin?
  end

  def create
    if current_user.is_admin?
      @project = Project.new(project_params)
      @project[:user_id] = session[:user_id]
      if @project.save
        redirect_to root_path
      else
        render "new"
      end
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if current_user.is_admin?
      if @project.update(project_params)
        redirect_to root_path
      else
        render "edit"
      end
    end
  end

  #NUNCA USAR
  def destroy
    if current_user.is_admin?
      if @project.destroy
        redirect_to root_path
      else
        redirect_to root_path
      end
    end
  end

  def complete
    if current_user.is_admin?
      @project.update_attribute(:completed, true)
      redirect_to project_path(@project)
    else
      redirect_to root_path
    end
  end

  def uncomplete
    if current_user.is_admin?
      @project.update_attribute(:completed, false)
    else
      redirect_to root_path
    end
  end

  def canceled
    if current_user.is_admin?
      @projects = Project.where(canceled: true)
    else
      @projects = Project.where("user_id = :user_id and canceled = :canceled", { user_id: current_user.id, canceled: true })
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def load_project
      @project = Project.find(params[:id])
    end
end
