class UsersController < ApplicationController
  include Users::Shared::ManagementActions
  before_action :set_user,
                :require_login,
                only: [:show, :edit, :update, 
                       :change_password_and_email, :destroy]

  private

  def successful_creation_message
    "User registered"
  end

  def successful_redirection_path
    if current_user
      @user
    else
      root_path
    end
  end
end
