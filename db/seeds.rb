# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

params = { campaign:{
		title: Faker::Name.title,
		description: Faker::Company.catch_phrase,
		start_date:Faker::Date.backward(25),
		end_date:Faker::Date.forward(25),
		topics_attributes:[{ title: Faker::Name.title, description: Faker::Company.catch_phrase }],
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