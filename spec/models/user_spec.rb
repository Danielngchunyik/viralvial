require 'rails_helper'

RSpec.describe User, type: :model do

  describe "create user without password" do
    it "should assign default password" do
      expect(User.create(email: 'facebook@faceobok.com').crypted_password).not_to be_nil
    end
  end

end
