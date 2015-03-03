class HomeController < ApplicationController

  def index
    @contact = Contact.new
    featured_campaigns = Campaign.where(featured: true)


    #redirects if user is logged in
    if current_user
      redirect_to campaigns_path
    end
  end
end