class ContactsController < ApplicationController
  set_tab :contact_us
  def new
  end
  
  def create
    message = Message.new(params[:message])

    if message.valid?
      ContactsMailer.contact_mail(message).deliver
      redirect_to root_url, :notice => 'Mail Sent to Admin.'
    else
      flash[:error] = message.errors.full_messages[0]
      render :action => :new
    end
  end
end
