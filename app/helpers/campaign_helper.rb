module CampaignHelper
  def number_of_shares(topic)
    topic.num_of_shares - current_user.posts.where(topic_id: topic.id, status: "active").count
  end

  def campaign_reward(campaign)
    if current_user
      score = current_user.social_score.viral_score
      campaign.reward * Tier::RewardMultiplier.new.get(score)
    else
      "Up to #{campaign.reward}"
    end
  end

  def reward_range(campaign)
    lowest = campaign.reward * Tier::RewardMultiplier.new.get(1)
    highest = campaign.reward * Tier::RewardMultiplier.new.get(100)

    { lowest: lowest, highest: highest}
  end
end
