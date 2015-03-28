class ApplicationController < ActionController::Base
  before_action :check_and_set_user_interest_form

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  # If user has not updated his main interest, set attributes for interest form to render
  def check_and_set_user_interest_form
    if current_user && current_user.try(:interest_not_selected?)
      @interest_form_user = UserDecorator.new(current_user)
      @options = Option.first.interest_option_list
    end
  end

  def not_authenticated
    flash[:error] = 'Please login first'
    redirect_to root_path
  end
end
