# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Super_Manager = User.create!(name: 'Super Manager', email: 'supermanager@myconference.com', password: 'ZXasqw12', password_confirmation: 'ZXasqw12', role: 'Super_Manager')

Manager = User.create!(name: 'Manager', email: 'manager@myconference.com', password: 'ZXasqw12', password_confirmation: 'ZXasqw12', role: 'Manager')