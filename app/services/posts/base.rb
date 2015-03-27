class Posts::Base

  attr_accessor :user, :post, :topic, :provider, :token, :secret

  def initialize(user, post = nil)

    @user = user
    @post = post 

    set_token
  end
end