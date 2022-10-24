class SendUserEmailMailer < ApplicationMailer
  def quote_update
    mail(to: params['email'], subject: "Atualização na Cotação: #{params['quote_title']}")
  end

  def forgot_password
    mail(to: params['email'], subject: 'Recuperação de senha')
  end

  def new_agreement
    mail(to: params['email'], subject: 'Novo acordo na plataforma')
  end
end
