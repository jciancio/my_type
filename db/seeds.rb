User.destroy_all
UserLike.destroy_all
Stock.destroy_all

5.times do |n|
  user = {
    name: Faker::Name.unique.name,
    email: "#{(1..1000).to_a.sample}#{Faker::Internet.unique.email}",
    password: 'password',
    type: 'Stock'
  }

  User.create!(user.merge!(gender: (n % 2)))
end

10.times do |n|
  user = {
    name: Faker::Name.unique.name,
    email: "#{(1..1000).to_a.sample}#{Faker::Internet.unique.email}",
    password: 'password',
    type: 'User'
  }

  User.create!(user.merge!(gender: (n % 2)))
end

users = User.all.map(&:id)

10.times do |n|
  UserLike.create!(user_id: users[(n-1)], like_id: users[n])
end
