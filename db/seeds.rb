# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
first_plan = Plan.create(name: "Five Dollars A Month", price: 5.00)
puts "The first plan was created. "
puts "The plan id is: #{first_plan[:id]}"