class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  def destroy_with_social_media(user)
    social_media_delete(user)
    destroy
  end

  def get_social_media(user)
    retrieve_social_media(user)
  end

  def self.social_media_share(user, provider, post_params, topic)

    @post = provider_to_class(provider).new(post_params.merge(topic_id: topic.id, user_id: user.id))
    
    start_social_media_post(user, post_params, topic)

    external_id = @social_media_post.save
    
    @post.update!(external_post_id: external_id)
    
    @social_media_post
  end

  def self.provider_to_class(provider)
    case provider
    when 'facebook'
      FacebookPost
    when 'twitter'
      TwitterPost
    end
  end

  def self.start_social_media_post(user, post_params, topic)
    @social_media_post = @post.publish_to_social_media_class.new(user, @post, post_params, topic.id)
  end
end
