class UserMailer < ApplicationMailer
  # Recebe nos parâmetros o usuário e a senha e então envia um email
  # contendo seu login e sua senha.
  # OBS: Não adianta utilizar apenas usuário como parâmetro, pois a senha dentro do
  # objeto virá criptografada.
  def new_user_mail(user, password)
    @user = user
    @password = password

    mail to: user.email, subject: "Sua conta da Ceará Steel foi criada"
  end
end
