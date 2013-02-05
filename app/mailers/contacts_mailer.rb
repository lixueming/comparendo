class ContactsMailer < ActionMailer::Base
  default :from => "support@comparendo.ch"
  default :to => "support@comparendo.ch"

  def contact_mail(message)
    @message = message
    mail(:subject => "[Comparendo Contact Request] #{message.subject}")
  end
end