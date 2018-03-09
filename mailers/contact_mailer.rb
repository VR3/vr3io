class ContactMailer < ApplicationMailer
	default from: 'admin@vr3.io'
  default to: 'oscarchavezromero@gmail.com'

  def contact_email(name, email, body)
  	@name = name
  	@email = email
  	@body = body

  	mail(from: email, subject: 'VR3.io | Mensaje de Contacto')
  end
  layout 'mailer'
end
