require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "reset_password_email" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.reset_password_email(user) }

    before(:each) { user.reset_password_token = '123123123' }

    it "renders the headers" do
      expect(mail.subject).to eq("Your password has been reset")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["donotreply@viralvial.com"])
    end
  end

end
