# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#include RandomData
 
 # Create Users
 5.times do
   user = User.new(

   #name:     RandomData.random_name,
   email:    Faker::Internet.email,     #RandomData.random_email,
   password: Faker::Internet.password   #RandomData.random_sentence
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

 # Create Wikis
 50.times do
   Wiki.create!(
     title:  Faker::Lorem.sentence,     #RandomData.random_sentence,
     body:   Faker::Lorem.paragraphs    #RandomData.random_paragraph
   )
 end
 wikis = Wiki.all
 
 # Create an admin user
 admin = User.new(
  # name:     'Admin User',
   email:    'admin@email.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!
 
  # Create an premium user
 premium = User.new(
   #name:     'Admin User',
   email:    'premium@email.com',
   password: 'helloworld',
   role:     'premium'
 )
 premium.skip_confirmation!
 premium.save!

 
 # Create a standard user
 standard = User.new(
   #name:     'Standard User',
   email:    'standard@email.com',
   password: 'helloworld'
 )
 member.skip_confirmation!
 member.save!

 
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"