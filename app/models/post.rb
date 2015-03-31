class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :campaign
  enum status: [:active, :deleted]

  def destroy_with_social_media
    allowed_klasses = [Posts::Facebook::Delete, Posts::Twitter::Delete]

    klass = sanitize_klass("Delete", provider, allowed_klasses)
    klass.new(self).destroy

    destroy
  end

  def get_social_media(user)
    allowed_klasses = [Posts::Facebook::Retrieve, Posts::Twitter::Retrieve]

    klass = sanitize_klass("Retrieve", provider, allowed_klasses)
    post_stats = klass.new(self).display

    SocialScore::PostPerformance.new(self).calculate

    post_stats
  end

  def social_media_share
    allowed_klasses = [Posts::Facebook::Publish, Posts::Twitter::Publish]

    klass = sanitize_klass("Publish", provider, allowed_klasses)
    external_post_id = klass.new(self).save

    update(external_post_id: external_post_id)
  end

  def sanitize_klass(action, provider, allowed_klasses)
    klass = "Posts::#{provider}::#{action}"
    klass.sanitize_constant(allowed_klasses) 
  end
end
