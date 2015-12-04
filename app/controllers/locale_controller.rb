class LocaleController < ApplicationController
  before_action :set_locale
  
  def change_locale
    if current_user.update_attributes(locale: params[:locale])
      redirect_to :back
    else
      redirect_to :back, notice: "Não foi possível alterar o idioma."
    end
  end

  private
  def set_locale
    I18n.locale = current_user.locale || I18n.default_locale
  end
end
