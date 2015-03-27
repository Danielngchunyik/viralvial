class ParticipatedCampaignsController < ApplicationController
  before_action :require_login

  def index
    campaigns = []

    current_user.posts.each { |p| campaigns << p.campaign }
    @campaigns = CampaignDecorator.wrap(campaigns.uniq)
  end
end