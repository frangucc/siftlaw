class ContactsController < ApplicationController

  def send_email
    ContactMailer.feedback(params[:from_email], params[:to_email], params[:subject], params[:content]).deliver
    redirect_to root_path
  end
  
end
