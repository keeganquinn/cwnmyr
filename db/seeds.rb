# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin.email

user = CreateUserService.new.call
puts 'CREATED NORMAL USER: ' << user.email
