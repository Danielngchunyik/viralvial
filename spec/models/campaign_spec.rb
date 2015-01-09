require 'rails_helper'

describe Campaign do
  let(:campaign) { FactoryGirl.build(:campaign) }
  let(:user) { FactoryGirl.create(:user) }

  describe '#categories?' do
    it { expect(Campaign.order('created_at DESC').targeted_at(user)).to eq [] }
  end

  describe 'at_least_one_topic_required' do
    before { campaign.valid? }
    it do
      expect(campaign.errors.full_messages).to include(
        'Topic is missing. At least one topic is required.')
    end
  end
end
