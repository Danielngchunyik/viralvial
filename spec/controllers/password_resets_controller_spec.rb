require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe 'POST #create' do
    before { post :create, email: user.email }

    it { expect(user).to respond_to(:deliver_reset_password_instructions!) }
    it { expect(response).to redirect_to root_path }
  end

  describe 'GET #edit' do
    before { get :edit, id: user.id }

    it { expect(User).to respond_to(:load_from_reset_password_token) }
    it 'return user when token is found' do
      user.deliver_reset_password_instructions!
      expect(User.load_from_reset_password_token(user.reset_password_token))
        .to eq user
    end
  end

  describe 'PATCH #update' do

    before do
      user.deliver_reset_password_instructions!
      login_user(user)
    end

    context 'with a valid token' do

      let(:token) { user.reset_password_token }

      context 'with valid passwords' do
        before do
          patch :update, user: { password: 'password',
                                 password_confirmation: 'password' },
                         token: token, id: token
        end

        it { expect(assigns(:token)).to eq user.reset_password_token }
        it { expect(response).to redirect_to(root_path) }
        it { expect(assigns(:user)).not_to be_nil }
        it { expect(assigns(:user).reset_password_token).to be_nil }
      end

      context 'with invalid passwords' do
        before do
          put :update, user: { password: 'password',
                               password_confirmation: 'xxxxx' },
                       token: token, id: token
        end

        it { expect(assigns(:token)).to eq(user.reset_password_token) }
        it { expect(response).to render_template(:edit) }
      end

    end

  end
end
