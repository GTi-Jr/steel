# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.new(username: "admin_braz", email: "braz@braz.com", admin: true, password: "senhatopi", password_confirmation: "senhatopi")
user.save!
project = Project.new(user_id: user.id, name: "Projeto_teste", description: "sei lá")
project.save!

notice = Notice.new(title: "noticeTest", description: "essa é a noticia", project_id: project.id)
notice.save!
