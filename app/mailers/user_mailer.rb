class UserMailer < ActionMailer::Base
	def send_mail(mail_id)
		mail(to: mail_id, subject: "Thanks for using blog")
  end
end
