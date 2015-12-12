class NoticeMailer < ApplicationMailer
  # Recebe uma notícia como parâmetro
  # Carrega nas variáveis a notícia e o usuário a qual esta pertence e então
  # envia um email para o email do usuário
  def notice_created_mail(notice)
    @notice = notice
    @user = notice.project.user

    mail to: @user.email, subject: "Nova notificação no projeto #{@notice.project.name}"    
  end
end
