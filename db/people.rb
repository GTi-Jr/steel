require 'csv'

file = File.read(Rails.root.join('lib', 'people.csv'))
people = CSV.parse(file)
# row[0] nomes
# row[1] emails

people.each do |row|
  name = row[0]
  username = row[1].split('@')[0]
  email = row[1]
  phone = row[2]

  puts "Nome: #{name}"
  puts "Username: #{username}"
  puts "Email: #{email}"
  puts "Telefone: #{phone}\n\n"
end