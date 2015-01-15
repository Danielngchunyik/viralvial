class PostsController < ApplicationController

  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]

  def new
    authorize @campaign

    @post = @topic.posts.build
    fetch_shareable_images!

    @user_image = @topic.user_images.build # Set user_image for uploading
  end

  def create
    authorize @campaign
    begin
      @new_post = Post.social_media_share(current_user, params[:provider], post_params, @topic)
      flash[:notice] = "#{@new_post.post_type} created"
      redirect_to campaign_topic_post_path(@campaign, @topic, @new_post.post)
    rescue PublishError => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{params[:provider].capitalize}. Please link your account first!"
      render :new
    end
  end

  def show 
    @post_stats = @post.get_social_media(current_user)
  end

  def destroy
    @delete_post = @post.destroy_with_social_media(current_user)
    flash[:notice] = "Deleted!"
    redirect_to root_path
  rescue PublishError => e
    logger.info "[ERROR]: #{e.inspect}"
    flash[:error] = "Error deleting #{@delete_post.post_type}"
    redirect_to [@campaign, @topic, @post]
  end

  private

  def fetch_shareable_images!
    @images = []

    @topic.default_images.each do |image|
      @images << image
    end

    if user_image = @topic.user_images.find_by(user_id: current_user.id)
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
                                 :task_id, :user_id)
  end
end
