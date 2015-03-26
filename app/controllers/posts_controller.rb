class PostsController < ApplicationController

  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]
  respond_to :html, :js

  def new
    @post = @topic.posts.build
    fetch_shareable_images

    @user_image = @topic.user_images.build # Set user_image for uploading
  end

  def create
    return unless current_user.posts.where(topic_id: @topic.id).first == nil
    
    begin
      binding.pry
      @new_post = Post.social_media_share(current_user, post_params, @topic)
      flash[:notice] = "#{@new_post.post_type} created"
    rescue PublishError => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{params[:provider].capitalize}. Please link your account first!"
    end
    redirect_to campaign_path(@campaign)
  end

  def show 
   @post_stats = @post.get_social_media(current_user)
  rescue PublishError => e
    logger.info "[ERROR]: #{e.inspect}"
    redirect_to root_path, alert: "Post is deleted!"
  end

  def destroy
    @delete_post = @post.destroy_with_social_media(current_user)
    flash[:notice] = "Deleted!"
    redirect_to @campaign
  rescue PublishError => e
    logger.info "[ERROR]: #{e.inspect}"
    flash[:error] = "Error deleting #{@delete_post.post_type}"
    redirect_to [@campaign, @topic, @post]
  end

  private

  def fetch_shareable_images
    @images = @topic.default_images

    if user_image = @topic.user_images.find_by(user_id: current_user.id)
      @images << user_image
    end
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
    # authorize @campaign
  end

  def set_topic
    @topic = @campaign.topics.find(params[:topic_id])
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
