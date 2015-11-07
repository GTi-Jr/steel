class UsersController < ApplicationController
  layout "dashboard"

  before_action :load_user, only: [:show, :edit, :update]
  
  def index
      @users = User.all
  end

  def show
    session[:user_id] = params[:id]
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
      if @user.update_attributes(user_params)
        redirect_to users_url
      else
        render :edit
      end
  end

  def create
      @user = User.new(user_params)
      if @user.save
        UserMailer.new_user_mail(@user).deliver_later
        redirect_to customers_users_path
      else
        render :new
      end
  end

  def customers
    @users = User.where(admin: false)
  end

  def admins
    @users = User.where(admin: true)
  end

  def new_admin
    if current_user.is_admin?
      @user = User.new
    end
  end

  def create_admin
    if current_user.is_admin?
      @user = User.new(user_params)
      @user[:admin] = true

      if @user.save
        UserMailer.new_user_mail(@user).deliver_later
        redirect_to root_path
      else
        render "new"
      end
    else
      redirect_to root_path
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username,:name, :contact_name, :phone, :email,
                                 :password, :password_confirmation)
  end
end