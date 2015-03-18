class HomeController < ApplicationController

  def index
    @contact = Contact.new
    @campaigns = CampaignDecorator.wrap(Campaign.where(featured: true).limit(12))
    #redirects if user is logged in
    if current_user
      redirect_to campaigns_path
    end
  end
end