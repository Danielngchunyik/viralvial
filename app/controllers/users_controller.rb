class UsersController < ApplicationController
  include Users::ManagementActions

  def edit_interest
    @user = User.find(params[:id])
    authorize @user
    @options = Option.first.interest_option_list
  end
  
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
