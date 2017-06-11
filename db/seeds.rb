# ReactionDatum.destroy_all
# User.destroy_all
# UserLike.destroy_all
# KairosProfile.destroy_all
# Stock.destroy_all
reaction_data = Helpers.reaction_data[:frames]

stock_images = [
  # 'http://jonvilma.com/images/face-13.jpg',
  # 'https://s-media-cache-ak0.pinimg.com/originals/c8/33/e2/c833e2dbff0469309f5795ad4eadb8bc.jpg',
  # 'http://balletcenter.nyu.edu/wp-content/uploads/2017/03/Preeti-Vasudevan_Headshot_Saravankumar.jpg',
  # 'http://2.bp.blogspot.com/-3RU1bI1bfUM/Tk3FvOfOshI/AAAAAAAAASg/e1auUXp3hJI/s1600/Bordeaux_Andrea_737_ret.jpg',
  # 'http://helendon.com/wp-content/uploads/2015/04/rockville-md-headshot-photographer-1-15.jpg',
  # 'http://gabrielsolisphotography.com/wp-content/uploads/2015/08/Tawni_headshot_optimized.jpg',
  # 'http://3.bp.blogspot.com/-wvTCg3ZnkVQ/VFVFWl1rK8I/AAAAAAAABVg/UXdO7I-vxlE/s1600/wendy-actors-headshot-126.jpg',
  # 'https://www.scottphotographycompany.com/wp-content/uploads/2017/05/San-Antonio-headshot-photographer-1.jpg',
  # 'https://s-media-cache-ak0.pinimg.com/originals/e4/e9/ec/e4e9ec7b444abfda3e94026cb1248389.jpg',
  # 'http://cdn.c.photoshelter.com/img-get/I0000Gognjb9DHGw/s/900/900/YA0008Chinese-college-girl-smiles.jpg'
]

profile_images = [
  'http://imgur.com/2XVRi9u.jpg',
  'http://imgur.com/s1hqyLT.jpg',
  'http://imgur.com/82VtXrE.jpg',
  'http://imgur.com/Ufy2O7x.jpg',
  'http://imgur.com/1D5xpoJ.jpg',
  'http://imgur.com/60cxhah.jpg',
  'http://imgur.com/2QG0qsB.jpg',
  'http://imgur.com/5pNXCgx.jpg',
  'http://imgur.com/KetNIDa.jpg',
  'http://imgur.com/CJehGHh.jpg',
  'http://imgur.com/h117w9s.jpg',
  'http://imgur.com/Sg0y0KV.jpg',
  'http://imgur.com/HnTLNG3.jpg',
  'http://imgur.com/Q9Ndfhd.jpg',
  'http://imgur.com/PMfCJxO.jpg',
  'http://imgur.com/Hrb8N0g.jpg',
  'http://imgur.com/4BNN8m2.jpg',
  'http://imgur.com/dU4l8Gt.jpg',
  'http://imgur.com/pHrChsE.jpg',
  'http://imgur.com/ufR4JrV.jpg',
  'http://imgur.com/q2M5R4d.jpg',
  'http://imgur.com/ju6TnFE.jpg',
]

User.create!({
    name: 'Test',
    email: 'test@test.com',
    password: 'password',
    type: 'User',
    gender: 0
  })

5.times do |n|
  user = {
    name: Faker::Name.unique.name,
    email: "#{(1..1000).to_a.sample}#{Faker::Internet.unique.email}",
    password: 'password',
    type: 'Stock',
    # kairos_profile: KairosProfile.new(image_url: stock_images[n-1])
    # image_link: stock_images[n-1]
  }

  User.create!(user.merge!(gender: (n % 2)))
end

23.times do |n|
  n -= 1
  user = {
    name: Faker::Name.unique.name,
    email: "#{(1..1000).to_a.sample}#{Faker::Internet.unique.email}",
    password: 'password',
    type: 'User',
    # kairos_profile: KairosProfile.new(image_url: profile_images[n])
    # image_link: profile_images[n]
  }

  User.create!(user.merge!(gender: (n % 2)))
end

users = User.all.map(&:id)

10.times do |n|
  ul = UserLike.create!(user_id: users[(n-1)], like_id: users[n])
  data = ReactionDatumParser.new(reaction_data.sample(100)).prepare
  ReactionDatum.create!(data.merge(user_like: ul))
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

all_images = stock_images + profile_images
User.all.each_with_index do |u, idx|
  KairosProfile.seed_create_prof(u, idx, all_images)
  puts "Profile ##{idx+1}"
end

# 10.times do |n|
#   # tries = 10
#   # tries.times do
#   #   result = begin
#   #     KairosProfile.create!(user_id: users[(n-1)], image_url: faces[n])
#   #   rescue
#   #     nil
#   #   end
#   #   break if result
#   KairosProfile.create!(user_id: users[(n-1)], image_url: faces[n])
#   end
#   puts "Face ##{n+1} Accepted"
# end
#
# def create(user, link)
#   begin
#     KairosProfile.create!(user_id: user, image_url: link)
#   rescue
#     nil
#   end
# end
