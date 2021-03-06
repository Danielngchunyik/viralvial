class ApplicationController < ActionController::Base
  # logged_in? is a sorcery gem method
  before_action :check_and_set_user_interest_form, if: :logged_in?

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  private

  # If user has not updated his main interest, set attributes for interest form to render
  def check_and_set_user_interest_form
    return if current_user.admin?
    
    if current_user.try(:interest_not_selected?)
      @interest_user = UserDecorator.new(current_user)
      @options = Option.first.category_list
    end
  end

  def not_authenticated
    flash[:error] = 'Please login first'
    redirect_to root_path
  end
end
