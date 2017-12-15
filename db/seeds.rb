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
user1 = User.create!(username: "jobrannmous", email: "jobrann@mail.com", password: "password", first_name: "Jobrann", last_name: "Mous")
user2 = User.create!(username: "adri", email: "adrien@mail.com", password: "password", first_name: "Adrien", last_name: "Moison")
user3 = User.create!(username: "lolahfbk", email: "lola@mail.com", password: "password", first_name: "Lola", last_name: "Hfbk")
user4 = User.create!(username: "clementlf", email: "clement@mail.com", password: "password", first_name: "Clément", last_name: "Flinois")

user1.remote_photo_url = "http://res.cloudinary.com/dxlfgmaxy/image/upload/v1513258489/jobrann_m4ew6v.png"
user2.remote_photo_url = "http://res.cloudinary.com/dxlfgmaxy/image/upload/v1513257046/adrien_iadrk5.jpg"
user3.remote_photo_url = "http://res.cloudinary.com/dxlfgmaxy/image/upload/v1513257046/lola_iwmf6e.jpg"
user4.remote_photo_url = "http://res.cloudinary.com/dxlfgmaxy/image/upload/v1513257046/clement_iixvhl.jpg"

user1.save
user2.save
user3.save
user4.save
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
project_solo_completed = Project.create!(name: "Christmas Presents", goal_amount_total_cents: 15000, due_date: (Date.today + 8), category: Category.find_by_name("Gift"), saved_amount_total_cents: 15000, status: "Completed", description: "Getting organized and getting Christmas shopping out of the way early this year.")
project_group_active = Project.create!(name: "Summer Roadtrip!", goal_amount_total_cents: 160000, due_date: (Date.today + 150), category: Category.find_by_name("Travel"), saved_amount_total_cents: 72100, description: "We coded this app in a little under two weeks, so we're kind of tired. Time to get in the car, and drive straight to Party Town. Road trip!")
p "projects done"

p "creating userprojects"
userproject1 = UserProject.create!(user: user1, project: project_solo_completed, saved_amount_solo_cents: 15000)
userproject2 = UserProject.create!(user: user1, project: project_group_active, saved_amount_solo_cents: 5000, goal_amount_solo_cents: 40000, withdrawal_amount_total_cents: 200)
userproject3 = UserProject.create!(user: user2, project: project_group_active, saved_amount_solo_cents: 25700, goal_amount_solo_cents: 40000, withdrawal_amount_total_cents: 100)
userproject4 = UserProject.create!(user: user3, project: project_group_active, saved_amount_solo_cents: 18300, goal_amount_solo_cents: 40000, withdrawal_amount_total_cents: 200)
userproject5 = UserProject.create!(user: user4, project: project_group_active, saved_amount_solo_cents: 23100, goal_amount_solo_cents: 40000, withdrawal_amount_total_cents: 100)
p "userprojects done"
