require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe ".social_media_share" do
    let(:user) { create(:user) }
    let!(:authentication) { Authentication.create!(user: user, provider: 'twitter', token: 'badtoken', secret: 'badsecret', uid: 'foo') }
    let(:campaign) { create(:campaign) }
    let(:topic) { campaign.topics.first }
    let(:post) { topic.posts.build(message: "foo", image: "nothing", provider: 'Twitter', user_id: user.id, campaign_id: campaign.id) }

    it "Twitter: should raise exception when token is wrong" do
      WebMock.allow_net_connect!
      expect {
        post.social_media_share
      }.to raise_error()
    end

    it "Facebook: should raise exception when token is wrong" do
      WebMock.allow_net_connect!
    end

    # posting to facebook when we have bad token -> Facebook::Error::Unauthorized
    # posting to facebook with duplicate message -> Facebook:Error::Duplicate
    # ...
  end
end
