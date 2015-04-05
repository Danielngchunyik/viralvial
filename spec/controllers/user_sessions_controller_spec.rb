require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  describe 'GET new' do
    before { get :new }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET create' do
    context 'admin user' do
      before { post :create, email: admin.email, password: 'password' }
      it { expect(response).to redirect_to(admin_dashboard_path) }
    end

    context 'non-admin user' do
      before { post :create, email: user.email, password: 'password' }
      it { expect(response).to redirect_to(root_path) }
    end

    context 'invalid credential' do
      before { post :create }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'GET destroy' do
    before { user.update(primary_interest_list: "Sports") }
    before { login_user user }
    it do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end
