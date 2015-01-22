class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.new_contact(@contact).deliver_now
      flash[:notice] = "Your message has been delivered"
    else
      flash[:alert] = "An error occured while delivering the message"  
    end

    redirect_to root_path
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
