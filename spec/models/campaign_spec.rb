require 'rails_helper'

describe Campaign do
  describe '#categories?' do
    it "should return true when category_list is blank" do
      campaign = Campaign.new(start_date: Date.today, end_date: Date.today)
      user = User.new
      expect(campaign.conditions?(user)).to eq true
    end
  end
end
