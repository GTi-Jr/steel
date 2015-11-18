# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.new(username: "csteel", name: "SteelService", email: "csteel@csteel.com", 
                phone: "8512345678", admin: true, password: "senhatop", 
                password_confirmation: "senhatop")
user.save!
