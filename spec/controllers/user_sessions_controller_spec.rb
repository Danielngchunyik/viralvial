require 'rails_helper'

RSpec.describe UserSessionsController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  before { login_user(user) }
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET destroy" do
    it "returns http success" do
      get :destroy      
      expect(response).to redirect_to :users
    end
  end

end
