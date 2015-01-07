class UsersController < ApplicationController
  include Users::Shared::ManagementActions

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
