require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user_attributes) { FactoryGirl.attributes_for(:user, :without_password) }

  describe "create user without password" do
    it "should assign default password" do
      expect(User.create(user_attributes)).to be_valid
    end
  end

end
