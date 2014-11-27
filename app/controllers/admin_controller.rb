class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :check_authorization

  include Pundit

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def check_authorization
    if current_user && !current_user.admin?
      flash[:notice] = "You are not authorized"
      redirect_to root_url
    end
  end
end
