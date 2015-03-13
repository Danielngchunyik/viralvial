class UsersController < ApplicationController
  before_action :set_user, :require_login
  before_action :set_options, only: :edit
  respond_to :html, :js, :json

  def show
    authorize @user
    @campaigns = []

    @user.posts.each do |post|
      @campaigns << post.campaign
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    respond_with(@user)
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

  def set_options
    @options = Option.first.interest_option_list
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :blog_url,
                                 :password_confirmation, :name,
                                 :birthday, :gender, :race, :religion,
                                 :contact_number, :nationality, :location, :country,
                                 :marital_status, :role, :main_interest, :secondary_interest_list,
                                 authentication_attributes: [])
  end
end
