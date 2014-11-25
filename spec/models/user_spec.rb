require 'rails_helper'
require 'pry'
RSpec.describe User, type: :model do

  describe "create user without password" do
    it "should assign default password" do
      expect(User.create(email: 'facebook@facebook.com').password).not_to be_nil
    end
  end

end
