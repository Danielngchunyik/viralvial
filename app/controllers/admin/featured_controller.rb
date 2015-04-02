class Admin::FeaturedCampaignsController < AdminController
  def create
    @featured_campaign = Featured.new(featured_campaign_params)

    if @featured_campaign.save
      flash[:notice] = "Featured"
      redirect_to root_path
    end
  end

  private

  def featured_campaign_params
    params.require(:featured_campaign).permit(:campaign_id)
  end
end