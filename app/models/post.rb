class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :campaign

  def destroy_with_social_media
    allowed_klasses = [Posts::Delete::Facebook, Posts::Delete::Twitter]

    klass = sanitize_klass(provider, allowed_klasses)
    klass.new(self).destroy

    destroy
  end

  def get_social_media(user)
    allowed_klasses = [Posts::Retrieve::Facebook, Posts::Retrieve::Twitter]

    klass = sanitize_klass(provider, allowed_klasses)
    klass.new(self).display
  end

  def social_media_share
    allowed_klasses = [Posts::Publish::Facebook, Posts::Publish::Twitter]

    klass = sanitize_klass(provider, allowed_klasses)
    external_post_id = klass.new(self).save

    update(external_post_id: external_post_id)
  end

  def sanitize_klass(provider, allowed_klasses)
    klass = "Posts::Publish::#{provider}"
    klass.sanitize_constant(allowed_klasses) 
  end
end
