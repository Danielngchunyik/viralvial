class Provider::Facebook < Provider::Base
  def initialize; end

  def name
    'facebook'
  end

  def post_type
    'Post'
  end

  def retrieve_post
    @facebook_service = Posts::Facebook::RetrievePostStats.new(@fb_token, @user, @post)
    @fb_likes, @fb_comments = @facebook_service.display
  rescue => e
    logger.info ''
    logger.info "[ERROR]: #{e.inspect}"
    logger.info ''
  end

  def remove_post!(fb_post = @post)
    @post_service = Posts::Facebook::Destroy.new(@fb_token, fb_post)
    @post_service.destory
  end

  def publish!
    @post_service = Posts::Facebook::Create.new(@fb_token, @post_params, @topic_id, @user)
    @post_service.save
  end

  private

  def set_token
    @token = @user.authentications.find_by(provider: name).token
  end
end
