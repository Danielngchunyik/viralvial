class UserDashboardController < ApplicationController
  before_action :require_login

  def index
    @user = UserDecorator.new(current_user)

    # Call interest list
    @options = Option.first.interest_option_list
  end
end