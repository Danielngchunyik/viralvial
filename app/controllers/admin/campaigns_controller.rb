class Admin::CampaignsController < AdminController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

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
      flash[:alert] = 'deleted'
      redirect_to admin_campaigns_path
    else
      flash[:error] = 'error'
    end
  end

  private
  
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:status, :start_date, :end_date, :title, :invitation_list,
                                     :description, :min_age, :max_age, :min_socialite_score, 
                                     :max_socialite_score, :marital_status_list, :category_list, 
                                     :race_list, :religion_list, :country_list, :language, :private,
                                     images_attributes: [:campaign_id, :storage, :_destroy, :id], 
                                     topics_attributes: [:id, :num_of_posts, :num_of_comments, :num_of_likes, :description, :social_media_platform, :_destroy])
  end
end