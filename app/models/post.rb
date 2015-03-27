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

  def social_media_share
    klass = sanitize_klass(provider)
    external_post_id = klass.new(self).save

    update(external_post_id: external_post_id)
  end

  def sanitize_klass(provider)
    allowed_klasses = [Posts::Publish::Facebook, Posts::Publish::Twitter]
    
    klass = "Posts::Publish::#{provider}"
    klass.sanitize_constant(allowed_klasses) 
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
