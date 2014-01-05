# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts ""
puts "Beginning seeds.rb"
puts "Deleting all records in Plan database"
Plan.delete_all
if (Plan.exists?(1) == false)
  puts "Plan.exists?(1) is now false, as expected"
  # puts "Plan.first.nil? is true, as expected"
else
  puts "Captain, we have a problem..."
end
# Note: It is important that the plan's record id is '1', because stripe matches it's plans with the rails record #. 
first_plan = Plan.create(id: 1, name: "Five Dollars A Month", price: 5.00)
puts "The first plan was created. "
puts "The plan id is: #{first_plan[:id]}"
puts "Finished seeds.rb"
puts ""