class ContactMailer < ActionMailer::Base

  default from: "Viral Vial <noreply@viralvial.com>"
  default to: "Admin <admin@viralvial.com>"

  def new_contact(contact)

    @contact = contact

    mail subject: "Message from #{contact.name}"
  end
end
