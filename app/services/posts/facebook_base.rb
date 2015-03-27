class Posts::FacebookBase < Posts::Base

  def post_type
    "Post"
  end

  def set_token
    @token = post.user.authentications.find_by(provider: 'facebook').token
    @secret = nil
  end
end