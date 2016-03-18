class UserMailer < ActionMailer::Base
	default :from => "girikulkarni03@gmail.com"
	def send_mail(mail_id)		
		mail(:to => mail_id, :subject => "Welcome to blog")
  end
end
