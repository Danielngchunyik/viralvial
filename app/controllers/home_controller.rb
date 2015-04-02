class HomeController < ApplicationController

  def traffic_control
    if current_user && current_user.admin?
      redirect_to admin_dashboard_path 
    elsif current_user
      redirect_to user_path(current_user)
    else
      redirect_to landing_path
    end
  end
  
  def landing
    @contact = Contact.new
    @campaigns = FeaturedCampaignDecorator.wrap(Featured.where(featurable_type: "Campaign").limit(12))
  end
end
