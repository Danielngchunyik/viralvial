class ParticipatedCampaignsController < ApplicationController
  before_action :require_login

  def index
    campaigns = []

    current_user.posts.each do |post|
      campaigns << post.campaign
    end

    @campaigns = CampaignDecorator.wrap(campaigns)
  end
end