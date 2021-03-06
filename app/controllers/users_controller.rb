class UsersController < ApplicationController
  before_action :set_user, :require_login
  respond_to :html, :js, :json

  def show
    @providers = ['facebook', 'twitter']
    respond_with(@user)
  end

  def edit
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end
  
  private

  def set_user
    user = User.find(params[:id])
    authorize user
    @user = UserDecorator.new(user)
  end

  def user_params
    params.require(:user).permit(:email, :password, :blog_url, :image,
                                 :password_confirmation, :name,
                                 :birthday, :birthday_day, :birthday_month, :birthday_year, 
                                 :gender, :race, :religion, :contact_number, :nationality, :location, :country,
                                 :marital_status, :role, :main_interest, :secondary_interest_list,
                                 authentication_attributes: [])
  end
end
