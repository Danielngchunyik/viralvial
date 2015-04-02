# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

campaign_params = { campaign:{
		title: "Lorem Title",
		description: "Lorem Ipsum Desc",
		start_date: Date.today,
		end_date: Date.today + 30.days,
		topics_attributes:[{ title: "Lorem Topic Title", description: "Lorem Ipsum Desc", num_of_shares: 2, social_media_platform_list: 'Facebook, Twitter' }],
    reward: 50
	}
}

12.times do |e|
  e = Campaign.create(campaign_params[:campaign])
end

20.times do |u|
  
  fb = rand(100)
  tw = rand(100)
  total = fb + tw

  u = User.create
  u.build_social_score(facebook_followers: fb, twitter_followers: tw, total_followers: total).save
end

1.times do |o|
  o = Option.create!
  o.interest_option_list = "Games, Sports, Food"
  o.social_media_platform_option_list = "Facebook, Twitter"
  o.save
end