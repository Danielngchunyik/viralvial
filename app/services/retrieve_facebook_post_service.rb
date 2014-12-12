class RetrieveFacebookPostService
  attr_accessor :fb_token, :current_user, :post

  def initialize(fb_token, current_user, post)
    @fb_token = fb_token
    @current_user = current_user
    @post = post
  end

  def display
    retrieve_facebook_stats!

    fb_likes_params = @fb_post.raw_attributes['likes']
    fb_comments_params = @fb_post.raw_attributes['comments']

    fb_likes = fb_likes_params.nil? ? 0 : count_likes(fb_likes_params, current_user)
    fb_comments = fb_comments_params.nil? ? 0 : count_comments(fb_comments_params, current_user)

    [fb_likes, fb_comments]
  end

  private

  def count_likes(fb_likes_params, current_user)
    fb_likes = 0

    fb_likes_params['data'].each do |like|
      fb_likes += 1 unless like['name'] == current_user.name
    end

    fb_likes
  end

  def count_comments(fb_comments_params, current_user)
    fb_comments = 0

    fb_comments_params['data'].each do |comment|
      fb_comments += 1 unless comment['from']['name'] == current_user.name
    end

    fb_comments
  end

  def retrieve_facebook_stats!
    @fb_post = FbGraph::Post.fetch(@post.external_post_id,
                                   access_token: @fb_token)
  end
end