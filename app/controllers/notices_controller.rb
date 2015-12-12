class NoticesController < ApplicationController
  layout "dashboard"
  before_action :load_notice, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show]
  before_action :admin_only, only: [:new, :edit, :create, :update, :destroy]

  # GET
  # Lista todas as notícias referentes a um projetos
  def index
    @notices = Notice.where(project_id: session[:project_id])    
  end

  # GET
  # Carrega a notícia a partir da sessão e então carrega os anexos 
  # referentes a ela
  def show
    session[:notice_id] = params[:id]
    @attachments = Attachment.where(notice_id: session[:notice_id])
  end

  # GET
  # Instancia uma nova notícia e um novo anexo pertencente a ela
  def new
    @notice = Notice.new
    @attachments = @notice.attachments.build
  end

  # POST
  # Cria uma nova notícia, associa um projeto a ela a partir da sessão
  # e a salva no banco de dados. Caso seja possível salvá-la, é verificado
  # se há algum anexo. Caso haja, as URLs dos anexos são colocadas na notícia
  def create
    @notice = Notice.new(notice_params)
    @notice[:project_id] = session[:project_id]

    if @notice.save
      NoticeMailer.notice_created_mail(@notice).deliver_later
      
      unless params[:attachments].nil?
        params[:attachments]['image'].each do |a|
          @attachments = @notice.attachments.create!(:image => a)
        end
      end
      
      redirect_to project_path(@notice.project)
    else
      render :new
    end
  end

  # GET
  # Carrega a notícia para que seja possível editá-la
  def edit
  end

  # PATCH
  # Edita os atributos da notícia
  def update
      if @notice.update_attributes(notice_params)
        redirect_to project_path(@notice.project)
      else
        render :edit
      end
  end

  # DELETE
  # Destroi a notícia
  def destroy
    auxiliar_notice = @notice
    if @notice.destroy
      redirect_to project_path(auxiliar_notice.project)
    else
      redirect_to project_path(auxiliar_notice.project)
    end
  end

  private
  # Strong params
  # Permite apenas que os seguintes parâmetros sejam alterados
  def notice_params
    params.require(:notice).permit(:title, :description, attachments_attributes: [:id, :notice_id, :image])
  end

  # Carrega a notícia a partir do ID
  def load_notice
    @notice = Notice.find(params[:id])
  end

  # Checa se a notícia pertence ao usuário. Caso contrário, volta para a raiz
  # do sistema
  def check_user
    redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.has_project(@notice.project) || current_user.is_admin?
  end

  # Verifica se o usuário é administrador. Caso contrário volta para a raiz
  # do sistema
  def admin_only
    redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.is_admin?
  end
end