class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :campaign

  # Refer to TwitterPost and FacebookPost Classes

  def destroy_with_social_media(user)
    Posts::Delete::Facebook.new(user, self).destroy
    social_media_delete(user)
    destroy
  end

  def get_social_media(user)
    retrieve_social_media(user)
  end

  def self.social_media_share(user, post_params, topic)
    sanitize_provider(post_params[:provider])
    post = Post.new(post_params.merge(topic_id: topic.id, user_id: user.id, campaign_id: topic.campaign.id))
    
    klass = "Posts::Publish::#{post.provider}".constantize
    external_post_id = klass.new(user,post).save

    post.update!(external_post_id: external_post_id)

    # Returns post
    post
  end

  def self.sanitize_provider(provider)
    allowed_providers = ['Facebook', 'Twitter']
    
    return if allowed_providers.include?(provider)
    errors.add('Unallowed Provider!')
  end
end

# class FacebookPost < Post
#   def publish_to_social_media_class
#     Posts::Publish::Facebook
#   end

#   def retrieve_social_media(user)
#     Posts::Retrieve::Facebook.new(user, self).display
#   end

#   def social_media_delete(user)
#     Posts::Delete::Facebook.new(user, self).destroy
#   end
# end

# class TwitterPost < Post
#   def publish_to_social_media_class
#     Posts::Publish::Twitter
#   end

#   def retrieve_social_media(user)
#     Posts::Retrieve::Twitter.new(user, self).display
#   end

#   def social_media_delete(user)
#     Posts::Delete::Twitter.new(user, self).destroy
#   end
# end
