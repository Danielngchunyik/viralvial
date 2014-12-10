require 'pry'
class PostsController < ApplicationController
  before_action :set_campaign
  before_action :set_fb_token, except: [:new]

  def new
    @post = @campaign.posts.build
  end

  def create_fb_post
    if post_params[:image].nil?
      post_service = FacebookPostService.new(@fb_token, post_params, @campaign.id, current_user)
    else
      post_service = FacebookPhotoService.new(@fb_token, post_params, @campaign.id, current_user)
    end

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
    if @post.image.present?
      facebook_service = RetrieveFacebookPhotoService.new(@fb_token, current_user, @post)
    else
      facebook_service = RetrieveFacebookPostService.new(@fb_token, current_user, @post)
    end
    stats = facebook_service.display

    @fb_likes, @fb_comments = stats[0], stats[1]
  end

  private

  def set_fb_token
    @fb_token = current_user.authentications.find_by(provider: 'facebook').token
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def post_params
    params.require(:post).permit(:message, :image, :external_post_id, :external_post_id_type, :campaign_id, :user_id)
  end
end
