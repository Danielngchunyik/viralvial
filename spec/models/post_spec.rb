require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe ".social_media_share" do
    let(:user) { create(:user) }
    let!(:authentication) { Authentication.create!(user: user, provider: 'twitter', token: 'badtoken', secret: 'badsecret', uid: 'foo') }
    let(:campaign) { create(:campaign) }
    let(:topic) { campaign.topics.first }

    it "Twitter: should raise exception when token is wrong" do
      WebMock.allow_net_connect!
      expect {
        Post.social_media_share(user, "Share on Twitter", {message: "foo", image: "nothing"}, topic, campaign)
      }.to raise_error(PublishError)
    end

    it "Facebook: should raise exception when token is wrong" do
      WebMock.allow_net_connect!
    end

    # posting to facebook when we have bad token -> Facebook::Error::Unauthorized
    # posting to facebook with duplicate message -> Facebook:Error::Duplicate
    # ...
  end
end
