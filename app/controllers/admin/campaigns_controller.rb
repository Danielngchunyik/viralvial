class Admin::CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, except: [:index, :show]

  def index
    @campaigns = Campaign.order("created_at DESC")
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      flash[:notice] = "Campaign created"
    else
      flash[:error] = "Error creating campaign"
    end
    redirect_to @campaign
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:status, :start_date, :end_date, :title, :description)
  end
end