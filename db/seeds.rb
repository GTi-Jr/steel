# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
text = "Lorem ipsum dolor sit amet, consectetur adipiscing 
        elit. Ut hendrerit maximus ex venenatis consequat. Quisque consequat 
        tempus magna, et placerat tortor imperdiet ac. Praesent vulputate 
        metus sed nisl vulputate molestie. Vivamus tempor augue vel erat auctor,
        a maximus nisl pretium. Integer luctus sit amet mi sit amet finibus. 
        Nullam ac tincidunt mauris. Cras tempus ultrices tempor. In hac habitasse 
        platea dictumst. In blandit ipsum et euismod pretium. Vestibulum placerat 
        cursus libero, sollicitudin euismod ligula rhoncus id. Sed turpis purus, 
        venenatis at ante sit amet, sodales tincidunt lectus. Pellentesque id nunc 
        nec nunc sollicitudin tincidunt vel eget turpis. Morbi pulvinar dui velit, 
        in lacinia ligula pellentesque sit amet. Nullam hendrerit tincidunt ipsum 
        venenatis volutpat. Nullam ut dignissim enim. Pellentesque et ante ante. 
        Duis ornare lacus quis massa efficitur, sed accumsan ante maximus. Praesent 
        velit diam, auctor ac magna ac, malesuada vulputate risus. Aenean ut tellus 
        eu augue vestibulum venenatis. Phasellus leo magna, feugiat tempor tincidunt 
        id, cursus et odio. In porta egestas nibh, eu aliquet risus feugiat id. In 
        dignissim pretium est vitae mollis. Integer sed eros non dolor dapibus tempor 
        ornare eu arcu. Maecenas et egestas odio. Nunc vestibulum sollicitudin 
        tincidunt. Pellentesque eu neque sapien. Maecenas auctor, leo in tincidunt 
        viverra, enim augue euismod ligula, eu ultrices purus nulla a lorem"

user = User.new(username: "csteel", name: "SteelService", contact_name: "Dono", email: "csteel@csteel.com", 
                phone: "8512345678", admin: true, password: "senhatop", 
                password_confirmation: "senhatop")
user.save!

(0..100).each do |i|
  user = User.new(username: "User_#{i}", name: "Name_#{i}", contact_name: "Contact_#{i}", email: "email_#{i}@email.com", 
                phone: "0000000000", password: "caiocaio", 
                password_confirmation: "caiocaio")
  user.save!

  (0..2).each do |j|
    project = Project.new(name: "Project ##{j} for #{user.contact_name}",
                          user_id: user.id,
                          description: text)
    project.save!

    (0..1).each do |k|
      notice = Notice.new(title: "Title_#{k}", description: text.first(247), 
                          project_id: project.id)
      notice.save!
    end

  end

end
