class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :campaign

  def destroy_with_social_media(user)
    social_media_delete(user)
    destroy
  end

  def get_social_media(user)
    retrieve_social_media(user)
  end

  def self.social_media_share(user, provider, post_params, topic, campaign)
    post = provider_to_class(provider).new(post_params.merge(topic_id: topic.id, user_id: user.id, campaign_id: campaign.id))
    
    social_media_post = post.publish_to_social_media_class.new(user, post, post_params, topic.id)

    social_media_post_id = social_media_post.save

    post.update!(external_post_id: social_media_post_id)
    
    social_media_post
  end

  def self.provider_to_class(provider)
    case provider.split(' ')[2]
    when 'Facebook'
      FacebookPost
    when 'Twitter'
      TwitterPost
    end
  end
end
