require 'rails_helper'

RSpec.describe User, type: :model do

  describe "create user without password" do
    xit "should assign default password" do
      expect(User.create(email: 'facebook@facebook.com').password).not_to be_nil
    end
  end
end
