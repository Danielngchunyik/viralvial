class PostsController < ApplicationController
  before_action :set_campaign
  before_action :set_fb_token, except: [:new]

  def new
    @post = @campaign.posts.build
  end

  def create
    
    @fb_post = FbGraph::User.me(@fb_token).feed!(message: post_params[:message])

    @post = current_user.posts.build(post_params)
    @post.facebook_post_id = @fb_post.raw_attributes["id"]
    @post.campaign = @campaign

    if @post.save
      flash[:notice] = "Post created"
      redirect_to @post
    else
      flash[:error] = "Error!"
      render :new
    end
  end

  def show
    @post = @campaign.posts.find(params[:id])

    stats = @post.retrieve_facebook_stats(@fb_token, current_user)

    @fb_likes, @fb_comments, @fb_privacy = stats[0], stats[1], stats[2]
  end

  private

  def set_fb_token
    @fb_token = current_user.authentications.where(provider: 'facebook').first.token
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def post_params
    params.require(:post).permit(:message, :facebook_post_id, :campaign_id, :user_id)
  end
end
