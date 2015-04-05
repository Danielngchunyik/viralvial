# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

1.times do |o|
  o = Option.create!
  o.category_list = "Games, Sports, Food"
  o.social_media_list = "Facebook, Twitter"
  o.save
end