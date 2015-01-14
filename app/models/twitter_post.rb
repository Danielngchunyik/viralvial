class TwitterPost < Post
  def publish_to_social_media_class
    Posts::Publish::Twitter
  end

  def retrieve_social_media(user)
    Posts::Retrieve::Twitter.new(user, self).display
  end

  def social_media_delete(user)
    Posts::Delete::Twitter.new(user, self).destroy
  end

  def external_post_id_type
    "twitter"
  end
end
