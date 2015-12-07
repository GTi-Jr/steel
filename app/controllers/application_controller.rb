class ApplicationController < ActionController::Base
  layout :load_layout
  
  after_action :set_locale


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  # Checa se o parâmetro é permitido, então muda locale para ele.
  def language
    locale = params[:locale]
    options = ["pt", "en", "es"]

    if options.include?(locale) && current_user.update_attributes(locale: locale)
      redirect_to :back
    else
      redirect_to :back, notice: t('menu.locale_error')
    end
  end
  
  
  protected
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

  def load_layout
    if current_user
      "dashboard"
    else
      "application"
    end
  end


  private
  def set_locale
    if current_user.present?
      I18n.locale = current_user.locale
    else
      I18n.locale = I18n.default_locale
    end
  end
end
