User.destroy_all
UserLike.destroy_all
KairosProfile.destroy_all
Stock.destroy_all

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

faces = [
  'http://jonvilma.com/images/face-13.jpg',
  'http://s1.r29static.com//bin/entry/9f1/x,80/1536749/image.jpg',
  'https://cdn.techinasia.com/wp-content/uploads/2015/07/kuanhua-hsu.jpg',
  'http://2.bp.blogspot.com/-3RU1bI1bfUM/Tk3FvOfOshI/AAAAAAAAASg/e1auUXp3hJI/s1600/Bordeaux_Andrea_737_ret.jpg',
  'https://s-media-cache-ak0.pinimg.com/originals/cd/32/30/cd32305b2a778c2a3805a7baea545b9b.jpg',
  'http://www.ewtn.com/SERIES/2003/Choices_we_face.jpg',
  'https://ichef-1.bbci.co.uk/news/660/cpsprodpb/1782E/production/_95720369_gillanreuters.jpg',
  'http://www.telegraph.co.uk/content/dam/business/2016/09/20/gsk-Emma-Walmsley-large_trans_NvBQzQNjv4BqNJjoeBT78QIaYdkJdEY4CnGTJFJS74MYhNY6w3GNbO8.jpg',
  'http://www.bostonexecutiveheadshots.com/wp-content/uploads/2014/10/boston-headshot-photographer-40.jpg',
  'http://balletcenter.nyu.edu/wp-content/uploads/2017/03/Preeti-Vasudevan_Headshot_Saravankumar.jpg'
]

10.times do |n|
  KairosProfile.create!(user_id: users[(n-1)], image_url: faces[n])
  puts "Face ##{n+1} Accepted"
end
