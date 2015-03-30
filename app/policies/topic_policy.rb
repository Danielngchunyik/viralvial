class TopicPolicy < ApplicationPolicy
  def new?
    user.admin? ||
    (user.posts.where(topic_id: record.id).count < record.num_of_shares && 
      record.campaign.conditions?(user))
  end

  def create?
    new?
  end

  def destroy?
    true
  end
end
