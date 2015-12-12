class ApplicationMailer < ActionMailer::Base
  # Define o email padrão que enviará os emails.
  # Pode ser qualquer nome, não é um email de verdade. É apenas o nome
  # que o SendGrid coloca. Quem envia na verdade é ele.
  default from: "diretoria@cearasteel.com.br" 
  layout 'mailer'
end
