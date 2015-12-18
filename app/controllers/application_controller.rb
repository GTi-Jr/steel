class ApplicationController < ActionController::Base
  layout :load_layout
  
  after_action :set_locale


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  # Checa se o parâmetro é permitido, então muda locale para ele.
  def language
    locale = params[:locale]
    options = ["pt-BR", "en-US", "es-ES"]

    if options.include?(locale) && current_user.update_attributes(locale: locale)
      redirect_to :back
    else
      redirect_to :back, notice: t('menu.locale_error')
    end
  end
  
  
  protected
  # Checa os parâmetros permitidos nos três métodos abaixo
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name,
                                                            :contact_name, :phone,
                                                            :email, :password, 
                                                            :password_confirmation, 
                                                            :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, 
                                                            :contact_name, :phone, 
                                                            :username, :email, 
                                                            :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :name, 
                                                                   :contact_name, 
                                                                  :phone, :email, 
                                                                  :password, 
                                                                  :password_confirmation, 
                                                                  :current_password) }
  end

  # Caso esteja logado, o layout será dashboard, caso contrário, será
  # um layout em branco
  def load_layout
    if current_user
      "dashboard"
    else
      "application"
    end
  end

  # Define o locale do sistema de acordo com o locale guardado
  # no banco de dados do usuário
  def set_locale
    if current_user.present?
      I18n.locale = current_user.locale
    else
      I18n.locale = :'pt-BR' # I18n.default_locale
    end
  end
end
