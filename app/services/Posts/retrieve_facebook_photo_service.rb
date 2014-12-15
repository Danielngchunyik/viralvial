class Posts::RetrieveFacebookPhotoService
  attr_accessor :fb_token, :current_user, :post

  def initialize(fb_token, current_user, post)
    @fb_token = fb_token
    @current_user = current_user
    @post = post
  end

  def display
    retrieve_facebook_stats!

    fb_likes_params = @fb_post.likes
    fb_comments_params = @fb_post.comments

    fb_likes = fb_likes_params.nil? ? 0 : count_likes(fb_likes_params, current_user)
    fb_comments = fb_comments_params.nil? ? 0 : count_comments(fb_comments_params, current_user)

    [fb_likes, fb_comments]
  end

  private

  def count_likes(fb_likes_params, current_user)
    fb_likes = 0

    for x in 0..fb_likes_params.count-1
      fb_likes += 1 unless fb_likes_params.from(x)[0].raw_attributes["name"] == current_user.name
    end

    fb_likes
  end

  def count_comments(fb_comments_params, current_user)
    fb_comments = 0

    for x in 0..fb_comments_params.count-1
      fb_comments += 1 unless  fb_comments_params.from(x)[0].raw_attributes["from"]["name"] == current_user.name
    end

    fb_comments
  end

  def retrieve_facebook_stats!
    @fb_post = FbGraph::Photo.new(@post.external_post_id,
                                   access_token: @fb_token)
  end
end
