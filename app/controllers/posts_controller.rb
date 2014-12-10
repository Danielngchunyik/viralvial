class PostsController < ApplicationController
  before_action :set_campaign
  before_action :set_fb_token, except: [:new]

  def new
    @post = @campaign.posts.build
  end

  def create_fb_post
    post_service = FacebookPostService.new(@fb_token, post_params, @campaign.id, current_user)
    if post_service.save
      flash[:notice] = "Post created"
      redirect_to [@campaign, post_service.post]
    else
      flash[:error] = "Error!"
      render :new
    end
  end

  def show
    @post = @campaign.posts.find(params[:id])
    @facebook = @campaign.tasks.where(social_media_platform: 'facebook').first
    facebook_service = FacebookService.new(@fb_token, current_user, @post)
    stats = facebook_service.display

    @fb_likes, @fb_comments, @fb_privacy = stats[0], stats[1], stats[2]
  end

  private

  def set_fb_token
    @fb_token = current_user.authentications.find_by(provider: 'facebook').token
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def post_params
    params.require(:post).permit(:message, :external_post_id, :external_post_id_type, :campaign_id, :user_id)
  end
end
