class FeaturedCampaignDecorator < BaseDecorator

  def self.wrap(collection)
    collection.map do |object|
        CampaignDecorator.new(object.featurable)
    end
  end
end