class FacebookPost < Post
  def publish_to_social_media_class
    Posts::Publish::Facebook
  end

  def retrieve_social_media(user)
    Posts::Retrieve::Facebook.new(user, self).display
  end

  def social_media_delete(user)
    Posts::Delete::Facebook.new(user, self).destroy
  end

  def external_post_id_type
    "facebook"
  end
end
