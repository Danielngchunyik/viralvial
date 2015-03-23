class CampaignsController < ApplicationController
  require 'will_paginate/array'
  
  before_action :set_campaign, only: [:show]
  before_action :require_login

  def index
    campaigns = CampaignDecorator.wrap(Campaign.order("created_at DESC"))
    @campaigns = campaigns.paginate(page: params[:page], per_page: 8)
    # @campaigns.targeted_at(current_user)
    # @invited_campaigns = Campaign.order("created_at DESC").invited?(current_user)
  end

  def show
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
