module Posts::Controller::Methods

#methods for Posts Controller

  def post_type(provider)
    case provider
    when "facebook"
      "Post"
    when "twitter"
      "Tweet"
    end
  end

  def get_social_media_and_show!
    case @post.external_post_id_type
    when "facebook"
      retrieve_facebook_post!
    when "twitter"
      retrieve_twitter_post!
    end
  end

  def get_social_media_and_post!
    case params[:provider]
    when "facebook"
      post_on_facebook!
    when "twitter"
      post_on_twitter!
    end
  end

  def get_social_media_and_delete!
    case @post.external_post_id_type
    when "facebook"
      delete_facebook_post!
    when "twitter"
      delete_twitter_post!
    end
  end

  def save_post_and_redirect
    if @post_service.save
      flash[:notice] = "#{post_type(params[:provider])} created"
      redirect_to [@campaign, @post_service.post]
    else
      flash[:error] = "Error!"
      render :new
    end
  end

  def delete_post_and_redirect(provider)
    if @post_service.destroy
      flash[:notice] = "#{post_type(provider)} deleted"
      redirect_to root_path
    else
      flash[:error] = "Error!"
      redirect_to [@campaign, @post]
    end
  end

  def delete_twitter_post!
    set_twitter_token

    @post_service = Posts::Twitter::Destroy.new(@tw_token, @tw_secret, @post)
  end

  def delete_facebook_post!
    set_fb_token

    @post_service = Posts::Facebook::Destroy.new(@fb_token, @post)
  end

  def retrieve_facebook_post!
    set_fb_token

    @facebook = @campaign.topics.find_by(@post.topic_id)

    begin
      
      @facebook_service = Posts::Facebook::RetrievePostStats.new(@fb_token, current_user, @post)
      
      @stats = @facebook_service.display
      @fb_likes, @fb_comments = @stats[0], @stats[1]

    rescue => e

      logger.info "[ERROR]: #{e.inspect}"
      flash[:alert] = "Facebook post does not exist!"
      redirect_to root_path
    end
  end

  def retrieve_twitter_post!
    set_twitter_token

    @twitter = @campaign.topics.find_by(@post.topic_id)

    begin

      @twitter_service = Posts::Twitter::RetrieveTweetStats.new(@tw_token, @tw_secret, current_user, @post)

      @stats = @twitter_service.display
      @favourites, @retweets = @stats[0], @stats[1]

    rescue => e

      logger.info "[ERROR]: #{e.inspect}"
      flash[:alert] = "Twitter post does not exist!"
      redirect_to root_path
    end
  end

  def post_on_twitter!
    set_twitter_token

    @post_service = Posts::Twitter::Create.new(@tw_token, @tw_secret, post_params, @campaign.id, current_user)
  end

  def post_on_facebook!
    set_fb_token

    @post_service = Posts::Facebook::Create.new(@fb_token, post_params, @campaign.id, current_user)
  end

  def set_fb_token
    @fb_token = current_user.authentications.find_by(provider: 'facebook').token
  end

  def set_twitter_token
    auth = current_user.authentications.find_by(provider: 'twitter')
    @tw_token = auth.token
    @tw_secret = auth.secret
  end
end