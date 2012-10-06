class ContactsController < ApplicationController

  def send_email
    ContactMailer.feedback(params[:from_email], params[:to_email], params[:subject], params[:content]).deliver
    respond_to do |format|
      format.js {render '/contact_mailer/send_email.js'}
    end
  end
  
end
