class PostsController < ApplicationController
  include ShareableImages

  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]
  before_action :initialize_post, only: [:create]
  respond_to :html, :js

  def new
    @post = @topic.posts.build
    fetch_shareable_images

    # Set user_image for uploading
    @user_image = @topic.user_images.build 
  end

  def create
    begin
      @post.social_media_share
      flash[:notice] = "You've shared on #{@post.provider}!"
    rescue PublishError => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{post_params[:provider]}. Please link your account first!"
    end
    redirect_to campaign_path(@campaign)
  end

  def show 
   @post_stats = @post.get_social_media
  rescue PublishError => e
    logger.info "[ERROR]: #{e.inspect}"
    redirect_to root_path, alert: "Post is deleted!"
  end

  def destroy
    @delete_post = @post.destroy_with_social_media
    flash[:notice] = "Deleted!"
    redirect_to @campaign
  rescue PublishError => e
    logger.info "[ERROR]: #{e.inspect}"
    flash[:error] = "Error deleting #{@delete_post.post_type}"
    redirect_to [@campaign, @topic, @post]
  end

  private

  def initialize_post
    @post = @topic.posts.build(post_params.merge(user_id: current_user.id, campaign_id: @campaign.id))
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
    # authorize @campaign
  end

  def set_topic
    @topic = @campaign.topics.find(params[:topic_id])
    authorize @topic
  end

  def set_post
    @post = @topic.posts.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id,
                                 :topic_id, :user_id, :campaign_id)
  end
end
