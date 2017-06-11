# To get a list of matches
# Get the user's priorities
# 1. Create array of users for each attribute, sorted by how close to user's likes' mean
# 2. build score for each user (attribute_rank * attribute_weight)
# 3. Order by score

class UserSorter

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def users_sorted_by_attributes
    result = {}
    KairosProfile::ATTRIBUTES.each do |attrib|
      result[attrib] = all_users.sort_by do |u|
        (u.likes.map{|l| l.kairos_profile.send(attrib)}.to_data_collection.mean - u.kairos_profile.send(attrib)).abs
      end
    end
  end

  def priorities
    user.kairos_profile.priorities
  end

  def all_users
    @users ||= User.all
  end

end
