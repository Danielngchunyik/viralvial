require 'pry'
class PostsController < ApplicationController
  before_action :set_campaign
  before_action :require_login

  def new
    authorize @campaign

    @post = @campaign.posts.build
  end

  def create_social_post
    authorize @campaign

    begin
      case params[:provider]
      when "facebook"
        post_on_facebook!
      when "twitter"
        post_on_twitter!
      end
        
      if @post_service.save
        flash[:notice] = "#{post_type} created"
        redirect_to [@campaign, @post_service.post]
      else
        flash[:error] = "Error!"
        render :new
      end
    rescue
      flash[:error] = "Error posting on #{params[:provider].capitalize}. Please link your account first!"
      redirect_to action: 'new'
    end
  end

  def show
    set_post
   
    case @post.external_post_id_type
    when "facebook"
      retrieve_facebook_post!
    when "twitter"
      retrieve_twitter_post!
    end
  end

  def destroy
    set_post
    provider = @post.external_post_id_type

    # begin
    case @post.external_post_id_type
    when "facebook"
      delete_facebook_post!
    when "twitter"
      delete_twitter_post!
    end

    if @post_service.destroy
      flash[:notice] = "#{provider == 'facebook' ? 'Post' : 'Tweet'} deleted"
      redirect_to @campaign
    else
      flash[:error] = "Error!"
      redirect_to [@campaign, @post]
    end
    # rescue
  end

  private

  def post_type
    case params[:provider]
    when "facebook"
      "Post"
    when "twitter"
      "Tweet"
    end
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_post
    authorize @campaign
    @post = @campaign.posts.find(params[:id])
    authorize @post
  end

  def delete_twitter_post!
    set_twitter_token

    @post_service = Posts::Twitter::Destroy.new(@tw_token, @tw_secret, @post)
  end

  def delete_facebook_post!
    set_fb_token

    @post_service = Posts::Facebook::Destroy.new(@fb_token, @post)
  end

  def retrieve_facebook_post!
    set_fb_token

    @facebook = @campaign.topics.find_by(@post.topic_id)

    begin
      
      @facebook_service = Posts::Facebook::RetrievePostStats.new(@fb_token, current_user, @post)
      
      @stats = @facebook_service.display
      @fb_likes, @fb_comments = @stats[0], @stats[1]
    rescue

      flash[:alert] = "Facebook post does not exist!"
      redirect_to root_path
    end
  end

  def retrieve_twitter_post!
    set_twitter_token

    @twitter = @campaign.topics.find_by(@post.topic_id)

    begin

      @twitter_service = Posts::Twitter::RetrieveTweetStats.new(@tw_token, @tw_secret, current_user, @post)

      @stats = @twitter_service.display
      @favourites, @retweets = @stats[0], @stats[1]
    rescue

      flash[:alert] = "Twitter post does not exist!"
      redirect_to root_path
    end
  end

  def post_on_twitter!
    set_twitter_token

    if post_params[:image].nil?
      @post_service = Posts::Twitter::Create.new(@tw_token, @tw_secret, post_params, @campaign.id, current_user)
    else
      @post_service = Posts::Twitter::CreateWithPhoto.new(@tw_token, @tw_secret, post_params, @campaign.id, current_user)
    end
  end

  def post_on_facebook!
    set_fb_token

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

  def post_params
    params.require(:post).permit(:message, :provider, :image, :external_post_id, :external_post_id_type, :campaign_id, :task_id, :user_id)
  end
end
