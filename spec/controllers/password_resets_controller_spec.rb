require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(302)
    end
  end
end
