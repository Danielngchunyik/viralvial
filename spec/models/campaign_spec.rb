require 'rails_helper'

describe Campaign do
  describe '#categories?' do
    it "should return true when category_list is blank" do
      campaign = Campaign.create
      user = User.create
      expect(Campaign.order("created_at DESC").targeted_at(user)).to eq []
    end
  end
end
