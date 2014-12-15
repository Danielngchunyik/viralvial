class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]

  def index
    @campaigns = Campaign.where(privacy: true).order("created_at DESC").targeted_at(current_user)
    @posts = Post.where(user_id: current_user.id).order('created_at DESC')
  end

  def show
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
