class PostsController < ApplicationController
  include Posts::Controller::Methods

  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]

  def new
    authorize @campaign

    @post = @topic.posts.build
    fetch_shareable_images!

    #set user_image for uploading
    @user_image = @topic.user_images.build
  end

  def create
    authorize @campaign

    begin
      get_social_media_and_post!
      save_post_and_redirect
    rescue => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{params[:provider].capitalize}. Please link your account first!"
      redirect_to action: 'new'
    end
  end

  def show
    get_social_media_and_show!
  end

  def destroy
    provider = @post.external_post_id_type

    begin
      get_social_media_and_delete!

      delete_post_and_redirect(provider)

    rescue => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error deleting #{post_type(provider)}"
      redirect_to [@campaign, @post]
    end
  end

  private

  def fetch_shareable_images!
    @images = []

    @topic.default_images.each do |image|
      @images << image
    end

    if user_image = @topic.user_images.where(user_id: current_user.id).first
      @images << user_image
    end
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_topic
    @topic = @campaign.topics.find(params[:topic_id])
  end

  def set_post
    authorize @campaign
    @post = @topic.posts.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id,
                                 :external_post_id_type, :campaign_id, :task_id,
                                 :user_id)
  end
end
