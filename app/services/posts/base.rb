class Posts::Base

  attr_accessor :post, :token, :secret

  def initialize(post = nil)
    @post = post 

    set_token
  end
end