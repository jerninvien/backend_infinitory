# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Device.destroy_all

puts "Create fake devices for Labs, add some randomly to each use in Lab"

Lab.all.each do |lab|
  puts "lab is #{lab.name}"

  rand(4..12).times do |i|
    # puts "i is #{i+1}"
    device = Device.create(
      lab_id: lab.id,
      name: "PCR-#{i}"
    )

    device.save!

    lab.users.each do |user|
      if i % 3 === 0 then
        puts "Assigning #{device.name}\n to #{user.name}"

      end
    end
  end
end
