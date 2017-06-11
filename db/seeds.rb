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
  'http://cdn.c.photoshelter.com/img-get/I0000Gognjb9DHGw/s/900/900/YA0008Chinese-college-girl-smiles.jpg',
  'https://s-media-cache-ak0.pinimg.com/originals/e4/e9/ec/e4e9ec7b444abfda3e94026cb1248389.jpg',
  'http://2.bp.blogspot.com/-3RU1bI1bfUM/Tk3FvOfOshI/AAAAAAAAASg/e1auUXp3hJI/s1600/Bordeaux_Andrea_737_ret.jpg',
  'https://s-media-cache-ak0.pinimg.com/originals/cd/32/30/cd32305b2a778c2a3805a7baea545b9b.jpg',
  'http://www.ewtn.com/SERIES/2003/Choices_we_face.jpg',
  'https://ichef-1.bbci.co.uk/news/660/cpsprodpb/1782E/production/_95720369_gillanreuters.jpg',
  'http://www.telegraph.co.uk/content/dam/business/2016/09/20/gsk-Emma-Walmsley-large_trans_NvBQzQNjv4BqNJjoeBT78QIaYdkJdEY4CnGTJFJS74MYhNY6w3GNbO8.jpg',
  'http://www.bostonexecutiveheadshots.com/wp-content/uploads/2014/10/boston-headshot-photographer-40.jpg',
  'http://balletcenter.nyu.edu/wp-content/uploads/2017/03/Preeti-Vasudevan_Headshot_Saravankumar.jpg'
]

10.times do |n|
  # tries = 10
  # tries.times do
  #   result = begin
  #     KairosProfile.create!(user_id: users[(n-1)], image_url: faces[n])
  #   rescue
  #     nil
  #   end
  #   break if result
  KairosProfile.create!(user_id: users[(n-1)], image_url: faces[n])
  end
  puts "Face ##{n+1} Accepted"
end

def create(user, link)
  begin
    KairosProfile.create!(user_id: user, image_url: link)
  rescue
    nil
  end
end
