class Posts::Base

  attr_accessor :current_user, :post, :post_params, :topic_id, :fb_token, :tw_token, :tw_secret, :provider

  def initialize(current_user, post = nil, post_params = nil, topic_id = nil, provider = nil)

    @current_user = current_user
    @post = post 
    @post_params = post_params
    @topic_id = topic_id
    @provider = provider

    set_token
  end

  def post_type
    case @provider || @post.external_post_id_type
    when 'facebook'
      "Post"
    when 'twitter'
      "Tweet"
    end
  end

  def save_post!(ext_id, ext_type, topic_id)
    @post = @current_user.posts.build(
      @post_params.merge(external_post_id: ext_id,
                         external_post_id_type: ext_type,
                         topic_id: topic_id))
    @post.save
  end

  def set_token
    case @provider || @post.external_post_id_type
    when 'facebook'
      set_fb_token
    when 'twitter'
      set_tw_token
    end
  end

  def set_fb_token
    @fb_token = @current_user.authentications.find_by(provider: 'facebook').token
  end

  def set_tw_token
    auth = @current_user.authentications.find_by(provider: 'twitter')
    @tw_token = auth.token
    @tw_secret = auth.secret
  end
end