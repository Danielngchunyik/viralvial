class CampaignPresenter < BasePresenter

  def decorate_object
    @object = CampaignDecorator.new(object)
  end

  def num_of_shares_left
    object.topics.first.num_of_shares - user.posts.where(topic_id: object.id)
  end
end