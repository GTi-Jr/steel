require 'csv'

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


# Cria administrador
user = User.new(username: "csteel", name: "SteelService", contact_name: "Dono", email: "csteel@csteel.com", 
                phone: "8512345678", admin: true, password: "senhatop", 
                password_confirmation: "senhatop")
user.save!

# Lê planilha que baixei
file = File.read(Rails.root.join('lib', 'seeds', 'people.csv'))
people = CSV.parse(file)
# row[0] nomes
# row[1] emails

people.each do |row|
  name = row[0]
  username = row[1].split('@')[0]
  email = row[1]
  phone = row[2]

  user = User.new(username: username, name: "Empresa do(a) #{name}", 
                  contact_name: name, email: email, 
                  phone: phone, password: "caiocaio", 
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

