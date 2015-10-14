class ProjectsController < ApplicationController
  layout "dashboard"
  before_action :load_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new if current_user.admin
  end

  def create
    if current_user.admin
      @project = Project.new(project_params)

      if @project.save
        redirect_to root_path
      else
        render "new"
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.admin
      if @project.update(project_params)
        redirect_to root_path
      else
        render "edit"
      end
    end
  end

  def destroy
    if current_user.admin
      if @project.destroy
        redirect_to root_path
      else
        redirect_to root_path
      end
    end
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end

    def load_project
      @project = Project.find(params[:id])
    end
end
