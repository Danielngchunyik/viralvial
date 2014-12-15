class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.order("created_at DESC").targeted_at(current_user)
    @posts = Post.where(user_id: current_user.id).order('created_at DESC')
  end

  def show
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
