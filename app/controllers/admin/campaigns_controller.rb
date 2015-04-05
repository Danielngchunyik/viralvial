class Admin::CampaignsController < AdminController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_platform_options, only: [:new, :edit]

  def index
    @campaigns = Campaign.order("created_at DESC")
  end

  def new
    @campaign = Campaign.new
    @options = Option.first
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      flash[:notice] = "Campaign created"
      redirect_to [:admin, @campaign]
    else
      flash[:error] = "Error creating campaign"
      render action: 'new'
    end
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
      flash[:error] = 'deleted'
      redirect_to admin_campaigns_path
    else
      flash[:error] = 'error'
    end
  end

  private

  def set_platform_options
    @options = Option.first.social_media_list
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:status, :image, :banner, :start_date, :end_date, :title, :invitation_list,
                                     :description, :organizer, :category_list, :language, :private, :reward, :refcode,
                                     topics_attributes: [ :id, :_destroy, :title, :num_of_shares, { social_media_list: [] },
                                       :description, default_images_attributes: [ :topic_id, :storage, :id, :_destroy ] ])
  end
end
