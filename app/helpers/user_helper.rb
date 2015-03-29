module UserHelper
  def render_direction
    case params[:direction]
    when 'desc'
      'asc'
    when 'asc'
      'desc'
    else
      'asc'
    end
  end

  def user_has_updated_interest?
    current_user && current_user.try(:interest_not_selected?)
  end

  def non_admin_user_logged_in?
    current_user && !admin?
  end

  def user_linked_provider?(provider)
    true if current_user.authentications.find_by(provider: provider)
  end
end
