require 'faker'

User.delete_all
Restaurant.delete_all
Review.delete_all

# Users
10.times do
  asker = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
end
#

20.times do
  Restaurant.create( name: Faker::Company.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, cuisine: Faker::Commerce.product_name, owner_id: rand(1..10))
end

30.times do
  Review.create(body: Faker::Lorem.paragraph, rating: rand(1..6), user_id: rand(1..10), restaurant_id: rand(1..20))
end
