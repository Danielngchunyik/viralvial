class Admin::CampaignsController < AdminController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  def index
    @campaigns = Campaign.order("created_at DESC")
  end

  def new
    @campaign = Campaign.new
    authorize @campaign
  end

  def create
    @campaign = Campaign.new(campaign_params)
    authorize @campaign
    if @campaign.save
      flash[:notice] = "Campaign created"
    else
      flash[:error] = "Error creating campaign"
    end
    redirect_to [:admin, @campaign]
  end

  def show
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      flash[:notice] = "campaign updated"
      redirect_to [:admin, @campaign]
    else
      flash[:error] = "error updating"
      render action: 'edit'
    end
  end

  def destroy
    if @campaign.destroy
      flash[:alert] = 'deleted'
      redirect_to admin_campaigns_path
    else
      flash[:error] = 'error'
    end
  end

  private

  def authorize_campaign
    authorize @campaign
  end
  
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:status, :start_date, :end_date, :title, :description, images_attributes: [:storage])
  end
end