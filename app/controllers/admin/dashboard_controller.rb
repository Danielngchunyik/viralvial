class Admin::DashboardController < AdminController
  def index
    @campaigns = CampaignDecorator.wrap(Campaign.all)
    @featured_campaigns = FeaturedCampaignDecorator.wrap(Featured.where(featurable_type: "Campaign").limit(12))
    @new_featured_campaign = Featured.new
    @options = Option.first
    @transactions = RewardTransaction.all
  end
end
