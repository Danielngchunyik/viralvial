class PostsController < ApplicationController

  before_action :require_login
  before_action :set_campaign, :set_topic
  before_action :set_post, only: [:show, :destroy]

  def new
    authorize @campaign

    @post = @topic.posts.new
    fetch_shareable_images!

    @user_image = @topic.user_images.build # Set user_image for uploading
  end

  def create
    start_new_post
    authorize @campaign
    begin
      @new_post.save
      flash[:notice] = "#{@new_post.post_type} created"
      redirect_to [@campaign, @topic, @new_post.post]
    rescue PublishError => e
      logger.info "[ERROR]: #{e.inspect}"
      flash[:error] = "Error posting on #{params[:provider].capitalize}. Please link your account first!"
      render :new
    end
  end

  def show 
    get_post_stats
  end

  def destroy
    delete_post
    flash[:notice] = "#{@delete_post.post_type} deleted"
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

  def start_new_post
    case params[:provider]
    when 'facebook'
      @new_post = Posts::Publish::Facebook.new(
                    current_user, nil, post_params, @topic.id, params[:provider])
    when 'twitter'
      @new_post = Posts::Publish::Twitter.new(
                    current_user, nil, post_params, @topic.id, params[:provider])
    end
  end

  def get_post_stats
    case @post.external_post_id_type
    when 'facebook'
      @get_post = Posts::Retrieve::Facebook.new(current_user, @post)
    when 'twitter'
      @get_post = Posts::Retrieve::Twitter.new(current_user, @post)
    end
  end

  def delete_post
    case @post.external_post_id_type
    when 'facebook'
      @delete_post = Posts::Delete::Facebook.new(current_user, @post)
    when 'twitter'
      @delete_post = Posts::Delete::Twitter.new(current_user, @post)
    end
  end

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id,
                                 :external_post_id_type, :task_id, :user_id)
  end
end
