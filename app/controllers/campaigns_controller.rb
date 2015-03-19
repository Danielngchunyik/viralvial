
class CampaignsController < ApplicationController
  require 'will_paginate/array'
  
  before_action :set_campaign, only: [:show]
  before_action :require_login
  respond_to :html, :js

  def index
    campaigns = CampaignDecorator.wrap(Campaign.order("created_at DESC"))
    @campaigns = campaigns.paginate(page: params[:page], per_page: 4)
    # @campaigns.targeted_at(current_user)
    # @invited_campaigns = Campaign.order("created_at DESC").invited?(current_user)
    respond_with(@campaigns)
  end

  def show
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
