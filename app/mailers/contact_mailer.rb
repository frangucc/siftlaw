class ContactMailer < ActionMailer::Base

  def feedback(from_email, to_email, subject, content)
    @from_email
    @content = content
    mail(from: from_email, to: to_email, subject: subject)
  end
end
