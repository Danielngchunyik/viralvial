require 'rails_helper'

RSpec.describe OauthsController, :type => :controller do

  describe "POST oauth" do
    it "returns http success" do
      get :oauth, provider: 'facebook'
      expect(response).to have_http_status(302)
    end
  end
end
