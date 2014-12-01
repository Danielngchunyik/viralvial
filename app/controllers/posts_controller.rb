require 'pry'
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

    binding.pry
    if @post.save
      flash[:notice] = "Post created"
    end
  end

  def show
    @post = @campaign.posts.find(params[:id])
    @fb_post = FbGraph::Post.fetch(@post.facebook_post_id, access_token: @fb_token)
    
    @fb_likes = 0
    @fb_post.raw_attributes["likes"]["data"].each do |like|
      if like["name"] != current_user.name
        @fb_likes += 1
      end
    end

    @fb_comments = 0
    @fb_post.raw_attributes["comments"]["data"].each do |comment|
      if comment["from"]["name"] != current_user.name
        @fb_comments += 1
      end
    end

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
