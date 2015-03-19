class ParticipatedCampaignsController < ApplicationController
  before_action :require_login
  respond_to :html, :js

  def index
    @campaigns = []

    current_user.posts.each do |post|
      @campaigns << post.campaign
    end

    respond_with(@campaigns)
  end
end