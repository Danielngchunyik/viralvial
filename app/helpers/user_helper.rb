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

  def user_has_not_posted?(campaign)
    current_user.posts.where(campaign_id: campaign.id).count == 0
  end

  def total_reward_amount
    amount = current_user.reward_transactions.pluck(:amount)

    amount.inject{ |sum, el| sum + el }
  end
end
