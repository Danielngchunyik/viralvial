class Admin::CampaignsController < AdminController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_platform_options, only: [:new, :edit]

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
    binding.pry
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
    @options = Option.first.social_media_platform_option_list
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:status, :image, :banner, :start_date, :end_date, :title, :invitation_list,
                                     :description, :min_age, :max_age, :min_socialite_score, :organizer, 
                                     :max_socialite_score, :marital_status_list, :category_list, 
                                     :race_list, :religion_list, :country_list, :language, :private, 
                                     topics_attributes: [:id, :_destroy, :title, :num_of_shares, social_media_platform_list: [], :random_test,
                                                         :description, default_images_attributes: [:topic_id, :storage, :id, :_destroy]])
  end
end