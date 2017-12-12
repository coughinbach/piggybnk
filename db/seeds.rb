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

# *****************************************************************************
# IMPORTANT IMPORTANT
# ne pas faire Category.destroy_all + reseed des catégories SAUF si
# vous venez de faire un db:drop. Si on recharge tout à chaque fois, ça suce
# mon bandwidth Cloudinary :)
# *****************************************************************************


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
# name: "Travel",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/travel.png'))
# )
# shopping = Category.create!(
# name: "Shopping",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/shopping.png'))
# )
# event = Category.create!(
# name: "Event",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/event.png'))
# )
# gift = Category.create!(
# name: "Gift",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/gift.png'))
# )
# hobby = Category.create!(
# name: "Hobby",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/hobby.png'))
# )
# other = Category.create!(
# name: "Other",
# photo: File.open(Rails.root.join('db/fixtures/images/categories/other.png'))
# )
# p "categories done"

p "creating projects"
project1 = Project.create!(name: "Trip to Greece", goal_amount_total_cents: 40000, due_date: (Date.today + 20), category: Category.find_by_name("Travel"), saved_amount_total_cents: 14000)
project2 = Project.create!(name: "We Love Green", goal_amount_total_cents: 15000, due_date: (Date.today + 15), category: Category.find_by_name("Event"), saved_amount_total_cents: 8000)
project3 = Project.create!(name: "Birthday gift", goal_amount_total_cents: 20000, due_date: (Date.today + 10), category: Category.find_by_name("Gift"))
p "projects done"

p "creating userprojects"
userproject1 = UserProject.create!(user: user1, project: project1, withdrawal_amount_total_cents: 2000, saved_amount_solo_cents: 4000)
userproject2 = UserProject.create!(user: user2, project: project1, withdrawal_amount_total_cents: 2000, saved_amount_solo_cents: 10000)
userproject3 = UserProject.create!(user: user1, project: project2, withdrawal_amount_total_cents: 2000, saved_amount_solo_cents: 8000)
p "userprojects done"
