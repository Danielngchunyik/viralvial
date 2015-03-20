# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

params = { campaign:{
		title: "Lorem Title",
		description: "Lorem Ipsum Desc",
		start_date: Date.today,
		end_date: Date.today + 30.days,
		topics_attributes:[{ title: "Lorem Topic Title", description: "Lorem Ipsum Desc" }],
    featured: true
	}
}

12.times do |e|
  e = Campaign.create!(params[:campaign])
end

1.times do |o|
  o = Option.create!
  o.interest_option_list = "Games, Sports, Food"
  o.save
end