class CampaignsController < ApplicationController
  require 'will_paginate/array'
  
  before_action :require_login, only: :index
  respond_to :js, :html

  def index
    campaigns = CampaignDecorator.wrap(Campaign.order("created_at DESC").targeted_at(current_user))
    @campaigns = campaigns.paginate(page: params[:page], per_page: 12)

    respond_with(@campaign)
  end

  def show
    campaign = Campaign.find(params[:id])

    authorize campaign
    @campaign = CampaignDecorator.new(campaign)
  end
end
