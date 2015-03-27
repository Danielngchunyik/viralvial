class TopicPolicy < ApplicationPolicy
  def new?
    user.posts.where(topic_id: record.id).count < record.num_of_shares
  end

  def create?
    new?
  end
end