class Posts::Base

  attr_accessor :user, :post, :post_params, :topic_id, :provider, :token, :secret

  def initialize(user, post = nil, post_params = nil, topic_id = nil)

    @user = user
    @post = post 
    @post_params = post_params
    @topic_id = topic_id

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
end