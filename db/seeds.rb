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
# Category.destroy_all


p "creating users"
user1 = User.create!(username: "the_donald", email: "donny@trump.com", password: "password", first_name: "Donald", last_name: "Trump")
user2 = User.create!(username: "basedgod", email: "lilb@gmail.com", password: "password", first_name: "Lil", last_name: "B")
user3 = User.create!(username: "hadrienmatringe", email: "hadrien@gmail.com", password: "password", first_name: "Hadrien", last_name: "Matringe")
user1.remote_photo_url = "https://pbs.twimg.com/profile_images/874276197357596672/kUuht00m_400x400.jpg"
user2.remote_photo_url = "https://pbs.twimg.com/profile_images/1248509273/39198_1571854573776_1157872547_31663366_5779158_n_400x400.jpg"
user3.remote_photo_url = "https://pbs.twimg.com/profile_images/527783375923200000/hcrM2hqx_400x400.jpeg"
user1.save
user2.save
user3.save
p "users done"

# p "creating categories"
# travel = Category.create!(
#   name: "Travel",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/travel.png'))
# )
# shopping = Category.create!(
#   name: "Shopping",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/shopping.png'))
# )
# event = Category.create!(
#   name: "Event",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/event.png'))
# )
# gift = Category.create!(
#   name: "Gift",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/gift.png'))
# )
# hobby = Category.create!(
#   name: "Hobby",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/hobby.png'))
# )
# other = Category.create!(
#   name: "Other",
#   photo: File.open(Rails.root.join('db/fixtures/images/categories/other.png'))
# )
# p "categories done"

p "creating projects"
project1 = Project.create!(name: "Project 1", goal_amount_total: 200, due_date: (Date.today + 10), category: Category.find_by_name("Travel"))
project2 = Project.create!(name: "Project 2", goal_amount_total: 200, due_date: (Date.today + 10), category: Category.find_by_name("Gift"))
project3 = Project.create!(name: "Project 3", goal_amount_total: 200, due_date: (Date.today + 10), category: Category.find_by_name("Event"))
p "projects done"

p "creating userprojects"
userproject1 = UserProject.create!(user: user1, project: project1, withdrawal_amount_total: 20)
userproject2 = UserProject.create!(user: user2, project: project1, withdrawal_amount_total: 20)
userproject3 = UserProject.create!(user: user1, project: project2, withdrawal_amount_total: 20)
p "userprojects done"
