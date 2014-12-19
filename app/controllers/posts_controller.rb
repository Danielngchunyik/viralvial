class PostsController < ApplicationController
  before_action :set_campaign
  before_action :set_fb_token, except: [:new]
  before_action :set_twitter_token, except: [:new]
  before_action :require_login

  def new
    @post = @campaign.posts.build
  end

  def create_social_post
    begin
      case params[:provider]
      when "facebook"
        post_on_facebook!
      when "twitter"
        post_on_twitter!
      end
        
      if @post_service.save
        flash[:notice] = "Post created"
        redirect_to [@campaign, @post_service.post]
      else
        flash[:error] = "Error!"
        render :new
      end
    rescue
      flash[:alert] = "Error posting on #{params[:provider].capitalize}"
      redirect_to root_path
    end
  end

  def show
    @post = @campaign.posts.find(params[:id])
   
    case @post.external_post_id_type
    when "facebook"
      retrieve_facebook_post!
    when "twitter"
      retrieve_twitter_post!
    end
  end

  private

  def retrieve_facebook_post!
    @facebook = @campaign.tasks.where(social_media_platform: 'facebook').first

    begin
  
      if @post.image.present?
        @facebook_service = Posts::Facebook::RetrievePhotoStats.new(@fb_token, current_user, @post)
      else
        @facebook_service = Posts::Facebook::RetrievePostStats.new(@fb_token, current_user, @post)
      end
      
      @stats = @facebook_service.display
      @fb_likes, @fb_comments = @stats[0], @stats[1]
    rescue

      flash[:alert] = "Facebook post does not exist!"
      redirect_to root_path
    end
  end

  def retrieve_twitter_post!
    @twitter = @campaign.tasks.where(social_media_platform: 'twitter').first

    begin

      @twitter_service = Posts::Twitter::RetrievePostStats.new(@tw_token, @tw_secret, current_user, @post)

      @stats = @twitter_service.display
      @favourites, @retweets = @stats[0], @stats[1]
    rescue

      flash[:alert] = "Twitter post does not exist!"
      redirect_to root_path
    end
  end

  def post_on_twitter!
    if post_params[:image].nil?
      @post_service = Posts::Twitter::Create.new(@tw_token, @tw_secret, post_params, @campaign.id, current_user)
    else
      @post_service = Posts::Twitter::CreateWithPhoto.new(@tw_token, @tw_secret, post_params, @campaign.id, current_user)
    end
  end

  def post_on_facebook!
    if post_params[:image].nil?
      @post_service = Posts::Facebook::Create.new(@fb_token, post_params, @campaign.id, current_user)
    else
      @post_service = Posts::Facebook::CreateWithPhoto.new(@fb_token, post_params, @campaign.id, current_user)
    end
  end

  def set_fb_token
    @fb_token = current_user.authentications.find_by(provider: 'facebook').token
  end

  def set_twitter_token
    auth = current_user.authentications.find_by(provider: 'twitter')
    @tw_token = auth.token
    @tw_secret = auth.secret
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id, :external_post_id_type, :campaign_id, :task_id, :user_id)
  end
end
