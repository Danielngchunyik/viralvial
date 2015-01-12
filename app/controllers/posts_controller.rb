class PostsController < ApplicationController
  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]
  before_action :set_provider, except: :new

  def new
    authorize @campaign

    @post = @topic.posts.build
    fetch_shareable_images!

    @user_image = @topic.user_images.build # Set user_image for uploading
  end

  def create
    authorize @campaign
    begin
      @provider.publish!
      flash[:notice] = "#{@provider.post_type} created"
      redirect_to [@campaign, @topic, @post_service.post]
    rescue => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{@provider}. Please link your account first!"
      render :new
    end
  end

  def show
    @provider.retrieve_post
  end

  def destroy
    @provider.remove_post!
    flash[:notice] = "#{@provider.post_type} deleted"
    redirect_to root_path
  rescue => e
    logger.info "[ERROR]: #{e.inspect}"
    flash[:error] = "Error deleting #{@provider.post_type}"
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

  def set_provider
    case @post.external_post_id_type
    when 'facebook'
      @provider = Provider::Facebook.new(
                    current_user, @post, post_params, @topic.id)
    when 'twitter'
      @provider = Provider::Twitter.new(
                    current_user, @post, post_params, @topic.id)
    end
  end

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id,
                                 :external_post_id_type, :campaign_id, :task_id,
                                 :user_id)
  end
end
