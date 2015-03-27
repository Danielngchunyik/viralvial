class Posts::TwitterBase < Posts::Base

  def post_type
    "Tweet"
  end

  def set_token
    auth = post.user.authentications.find_by(provider: 'twitter')
    @token = auth.token
    @secret = auth.secret

    @twitter = Initializer::TwitterClient.new(@token, @secret)
  end
end
