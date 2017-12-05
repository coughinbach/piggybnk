# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserProject.destroy_all
Project.destroy_all
User.destroy_all


p "creating users"
user1 = User.create(username: "user1", email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
user2 = User.create(username: "user2", email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
user3 = User.create(username: "user3", email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
p "users done"

p "creating projects"
project1 = Project.create(name: "Project 1", goal_amount_total_cents: 200, due_date: (Date.today + 10))
project2 = Project.create(name: "Project 2", goal_amount_total_cents: 200, due_date: (Date.today + 10))
project3 = Project.create(name: "Project 3", goal_amount_total_cents: 200, due_date: (Date.today + 10))

p "projects done"

p "creating userprojects"
userproject1 = UserProject.create(user: user1, project: project1)
userproject2 = UserProject.create(user: user2, project: project1)
userproject3 = UserProject.create(user: user1, project: project2)
p "userprojects done"
