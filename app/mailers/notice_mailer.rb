class NoticeMailer < ApplicationMailer
  def notice_created_mail(notice)
    @notice = notice
    @user = notice.project.user

    mail to: @user.email, subject: "Nova notificação no projeto #{@notice.project.name}"    
  end
end
