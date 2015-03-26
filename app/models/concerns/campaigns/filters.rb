module Campaigns::Filters

  module ClassMethods
    def targeted_at(user)
      select do |campaign|
        campaign.conditions?(user)
      end
    end
  end

  def conditions?(user)
    [
      started?,
      active?,
      matching_interests?(user)
    ].all?
  end

  def active?
    end_date >= Date.today
  end

  def started?
    start_date <= Date.today
  end

  def matching_interests?(user)
    category_list.blank? || match_user_interests(user, "primary_interest_list")
  end

  def match_user_interests(user, method)
    user.send(method).present? && user.send(method).any? { |interest| category_list.include?(interest) }
  end
end
