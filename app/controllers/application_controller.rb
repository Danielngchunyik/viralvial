class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def admin_redirection
    redirect_to admin_dashboard if current_user.admin?
  end

  def not_authenticated
    flash[:alert] = 'Please login first'
    redirect_to login_path
  end
end
