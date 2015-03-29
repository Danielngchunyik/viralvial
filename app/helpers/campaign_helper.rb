module CampaignHelper
  def number_of_shares(topic)
    topic.num_of_shares - current_user.posts.where(topic_id: topic.id).count
  end
end