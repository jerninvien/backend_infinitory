# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
# require 'activerecord-import'

if Rails.env.development?
  if InviteCode.count == 0
    ic = []
   (10000..99999).each do |i|
     puts "Generating InviteCode: #{i}" if i % 10000 == 0
     ic << InviteCode.new(code: i)
   end
   InviteCode.import(ic, validate: false)
 end

  puts "Create seeds for Labs, Users, Devices"

  Lab.destroy_all
  10.times do
    lab = Lab.create(name: Faker::Name.name)

    
  end

end
