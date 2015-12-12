class ProjectsController < ApplicationController
  layout "dashboard"
  before_action :load_project, only: [ :show, :edit, :update, :destroy, :complete, 
                                      :uncomplete, :cancel, :uncancel ]

  before_action :admin_only, except: [:show]
  before_action :check_user, only: [:show]


  # Lista todos os projetos
  ## Caso admin, lista todos
  ## Caso usuário comum, lista apenas os próprios
  def index
    if current_user.is_admin?
      @projects = Project.order("created_at DESC").page(params[:page]).per_page(10)
    else
      @projects = Project.where(user_id: current_user.id).order("created_at DESC")
    end  
  end

  #Mostra o projeto
  def show
    session[:project_id] = params[:id]
    @notices = @project.notices.order("created_at DESC")
  end

  #Página para criar um projeto
  def new
    @project = Project.new
  end

  #Cria um projeto
  def create
    @project = Project.new(project_params)
    @project[:user_id] = session[:user_id]
    if @project.save
      redirect_to root_path
    else
      render "new"
    end
  end

  #Página para editar um projeto
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

  #NUNCA USAR *********************************
  ## Apaga, permanentemente, o projeto
  def destroy
    if current_user.is_admin?
      if @project.destroy
        redirect_to root_path
      else
        redirect_to root_path
      end
    end
  end
  # *******************************************

  # Lista os projetos que estão completos
  def complete
    if current_user.is_admin?
      @project.update_attribute(:completed, true)
      redirect_to project_path(@project)
    else
      redirect_to root_path
    end
  end

  # Lista os projetos que não estão completos
  def uncomplete
    if current_user.is_admin?
      @project.update_attribute(:completed, false)
      redirect_to project_path(@project)
    else
      redirect_to root_path
    end
  end

  # Lista os projetos cancelados
  def canceled
    if current_user.is_admin?
      @projects = Project.where(canceled: true)
    else
      @projects = Project.where("user_id = :user_id and canceled = :canceled", { user_id: current_user.id, canceled: true })
    end
  end

  # Cancela o projeto
  def cancel
    if current_user.is_admin?
      @project.update_attribute(:canceled, true)
      redirect_to project_path(@project)
    else
      redirect_to root_path
    end
  end

  # Descancela o projeto
  def uncancel
    if current_user.is_admin?
      @project.update_attribute(:canceled, false)
      redirect_to project_path(@project)
    else
      redirect_to root_path
    end
  end

  def query
    @projects = Project.text_search(params[:query]).page(params[:page]).per_page(10)

    redirect_to projects_path if @projects.nil?

    
  end

  private
    # Strong Parameters
    def project_params
      params.require(:project).permit(:name, :description)
    end

    # Pega os parametros para carregar o projeto do banco de dados
    def load_project
      @project = Project.find(params[:id])
    end

    def check_user
      redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.has_project(@project) || current_user.is_admin?
    end

    def admin_only
      redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.is_admin?
    end
end
