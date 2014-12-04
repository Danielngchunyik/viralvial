class UsersController < ApplicationController
  include UserManagementActions

  private

  def successful_creation_message
    "User registered"
  end

  def successful_redirection_url
    root_path
  end
end
