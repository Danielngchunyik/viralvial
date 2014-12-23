class AdminController < ApplicationController
  before_action :check_authorization, :require_login

  def check_authorization
    if current_user && !current_user.admin?
      flash[:notice] = "You are not authorized"
      redirect_to root_path
    end
  end
end
