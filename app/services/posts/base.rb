class Posts::Base

  attr_accessor :user, :post, :post_params, :topic_id, :provider, :token, :secret

  def initialize(user, post = nil, post_params = nil, topic_id = nil)

    @user = user
    @post = post 
    @post_params = post_params
    @topic_id = topic_id

    set_token
  end
end