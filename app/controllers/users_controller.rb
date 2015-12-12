class UsersController < ApplicationController
  layout "dashboard"

  before_action :load_user, only: [:show, :edit, :update]
  before_action :admin_only, except: [:edit, :update]
  
  # GET
  # Lista todos os usuários
  def index
    @users = User.all.page(params[:page]).per_page(10)
  end

  # Carrega o usuário e salva seu ID caso seja necessário adicionar
  # um projeto pertencente ele depois
  def show
    session[:user_id] = params[:id]
  end

  # GET
  # Instancia um novo usuário
  def new
    @user = User.new
  end

  # POST
  # Gera uma senha aleatória que é atribuída ao usuário
  # Caso o usuário seja salvo no banco de dados com sucesso, um email é 
  # enviado ao email cadastrado contendo seu login e sua senha
  def create
    generated_password = Devise.friendly_token.first(8)
    @user = User.new(user_params(generated_password))
    if @user.save
      UserMailer.new_user_mail(@user, generated_password).deliver_later
      redirect_to customers_users_path
    else
      render :new
    end
  end

  # GET
  # Carrega usuário para que seja possível editá-lo
  def edit
  end

  # PATCH
  # Atualiza os atributos do usuário
  def update
    if @user.update_attributes(user_params)
      redirect_to users_url
    else
      render :edit
    end
  end

  # GET
  # Carrega todos os usuários que não são administradores, ou seja, clientes
  def customers
    @users = User.where(admin: false).page(params[:page]).per_page(10)
  end

  # GET
  # Carrega todos os usuários administradores
  def admins
    @users = User.where(admin: true).page(params[:page]).per_page(10)
  end

  # GET
  # Instancia um novo usuário
  # Ao clicar no botão da página, o método chamado será o :create_admin
  def new_admin 
    @user = User.new  
  end

  # POST
  # Método chamado na view da ação :new_admin
  # Gera uma senha aleatória e a atribui ao usuário. Após isso, o campo 
  # administrador desse usuário é setado para TRUE.
  # Caso o novo administrador seja salvo com sucesso, um email será
  # enviado informando-o de seu novo login e senha.
  def create_admin
    generated_password = Devise.friendly_token.first(8)
    @user = User.new(user_params(generated_password))
    @user[:admin] = true
    if @user.save
      UserMailer.new_user_mail(@user, generated_password).deliver_later
      redirect_to root_path
    else
      render "new"
    end
  end

  # GET
  # Procura nos usuários e seus relacionados(projetos) pelo(s) termo(s) pesquisado(s)
  def query
    query = params[:query]

    if query.present?
      @users = User.text_search(query).page(params[:page]).per_page(10)
    else
      @users = nil
    end
  end

  private
  # Carrega usuário a partir do ID
  def load_user
    @user = User.find(params[:id])
  end

  # Strong params
  # A senha é carregada nos parâmetros e então enviada para o usuário para então ser 
  # salvo
  def user_params(password)
    params[:user][:password] = password
    params.require(:user).permit(:username, :name, :contact_name, :phone, :email,
                                 :password)
  end

  # Checa se o usuário é administrador, caso contrário é levado a raiz do sistema.
  def admin_only
    redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.is_admin?
  end
end