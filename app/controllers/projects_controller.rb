class ProjectsController < ApplicationController
  layout "dashboard"
  before_action :load_project, only: [ :show, :edit, :update, :destroy, :complete, 
                                      :uncomplete, :cancel, :uncancel ]

  before_action :admin_only, except: [:show]
  before_action :check_user, only: [:show]

  # GET
  # Lista todos os projetos
  # Caso admin, lista todos
  # Caso usuário comum, lista apenas os próprios
  def index
    if current_user.is_admin?
      @projects = Project.order("created_at DESC").page(params[:page]).per_page(10)
    else
      @projects = current_user.projects.order("created_at DESC")
    end  
  end

  # GET
  # Insere na sessão o ID do projeto
  # Carrega as notícias referentes ao projeto
  def show
    redirect_to root_path if @project.nil?
    session[:project_id] = params[:id]
    @notices = @project.notices.order("created_at DESC")
  end

  # GET
  # Instancia um novo projeto
  def new
    @project = Project.new
  end

  # GET
  # Cria um novo projeto
  # Associa o projeto ao usuário a partir do :user_id salvo na sessão ao entrar
  # na página do usuário
  def create
    @project = Project.new(project_params)
    @project[:user_id] = session[:user_id]
    if @project.save
      redirect_to root_path
    else
      render "new"
    end
  end

  # GET
  # Página para editar um projeto
  def edit
  end

  # PATCH
  # Atualiza o projeto
  def update
    if @project.update(project_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  #NUNCA USAR *********************************
  # Apaga, permanentemente, o projeto
  def destroy
    if @project.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  # *******************************************

  # GET
  # Lista os projetos que estão completos
  def complete
    @project.update_attribute(:completed, true)
    redirect_to project_path(@project)
  end

  # GET
  # Lista os projetos que não estão completos
  def uncomplete
    @project.update_attribute(:completed, false)
    redirect_to project_path(@project)
  end


  # Lista os projetos cancelados
  def canceled
    @projects = Project.where(canceled: true)
  end

  # PATCH
  # Cancela o projeto
  def cancel
    @project.update_attribute(:canceled, true)
    redirect_to project_path(@project)
  end

  # PATCH
  # Descancela o projeto
  def uncancel 
    @project.update_attribute(:canceled, false)
    redirect_to project_path(@project)
  end

  # GET
  # Procura nos projetos e notícias relacionadas o(s) termos(s) procurado(s)
  def query
    query = params[:query]

    if query.present?
      @projects = Project.text_search(query).page(params[:page]).per_page(10)
    else
      @projects = nil
    end
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

    # Checa se o projeto pertence ao usuário. Caso contrário é levado a raiz
    # do sistema
    def check_user
      redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.has_project(@project) || current_user.is_admin?
    end

    # Checa se o usuário é administrador. Caso contrário é levado a raiz do
    # sistema
    def admin_only
      redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.is_admin?
    end
end
