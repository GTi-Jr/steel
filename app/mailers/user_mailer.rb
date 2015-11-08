class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user_mail.subject
  #
  def new_user_mail(user, password)
    @user = user
    @password = password

    mail to: user.email, subject: "Sua conta da Ceará Steel foi criada"
  end
end
