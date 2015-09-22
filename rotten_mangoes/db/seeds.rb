# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = User.create([{email: 'harman@email.com',firstname: 'harman',lastname: 'dhillon',password: '123456',password_confirmation: '123456'},
                    {email: 'dhillon@email.com',firstname: 'aman',lastname: 'singh',password: '321',password_confirmation: '321'},
                    {email: 'email22@email.com',firstname: 'har',lastname: 'man',password: '456',password_confirmation: '456', is_admin: true}])