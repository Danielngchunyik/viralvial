class SocialScore::PostPerformance
  attr_accessor :user, :post, :campaign

  def initialize (post = nil)
    @post = post
    @user =  post.user
    @campaign = post.campaign
  end

  def calculate
    tally_average_score

    if user.posts.where(campaign_id: campaign.id).count >= campaign.topics.first.num_of_shares &&
      !user.reward_transactions.find_by(campaign_id: campaign.id)

      create_reward_transaction
    end
  end

  private

  def create_reward_transaction
    score = user.social_score.viral_score
    user.reward_transactions.create(amount: campaign.reward * Tier::RewardMultiplier.new.get(score), campaign_id: campaign.id)
  end

  def tally_average_score
    scores = user.posts.where(status: "active").order("created_at DESC").limit(8).pluck(:score)
    average_score = scores.inject{ |sum, el| sum + el }.to_f / 8
    user.social_score.update(average_post_scores: average_score)
  end
end
