class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]
  include CampaignHelper
  def index
    @campaigns = Campaign.order("created_at DESC").targeted_at(current_user)
    @invited_campaigns = Campaign.order("created_at DESC").invited?(current_user)
  end

  def show
    authorize @campaign
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
