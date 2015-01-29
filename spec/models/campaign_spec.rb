require 'rails_helper'

describe Campaign do
  let(:campaign) { FactoryGirl.build(:campaign) }
  let(:user) { FactoryGirl.create(:user) }

  describe '#categories?' do
    it { expect(Campaign.order('created_at DESC').targeted_at(user)).to eq [] }
  end

  describe 'at_least_one_topic_required' do
    it { expect(FactoryGirl.build(:campaign, topics_attributes: [])).not_to be_valid }
  end
end
