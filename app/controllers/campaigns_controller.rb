class CampaignsController < ApplicationController
  before_action :require_login, only: [:share]

  def index
  end

  def show
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
