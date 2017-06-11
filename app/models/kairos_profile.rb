class KairosProfile < ApplicationRecord
  belongs_to :user
  # before_save :set_attribs

  validates :user, uniqueness: true

  ATTRIBUTES = [
    :chin_to_eye_height,
    :eye_width,
    :face_proportion,
    :hispanic,
    :asian,
    :white,
    :black,
    :other
  ].freeze

  def data_call
    Facey.new(image_url)
  end

  def set_attribs
    data = data_call
    self.chin_to_eye_height = data.chin_to_eye_height
    self.eye_width = data.eye_width
    self.face_proportion = data.face_proportion
    self.hispanic = data.races.hispanic
    self.asian = data.races.asian
    self.white = data.races.white
    self.black = data.races.black
    self.other = data.races.other
    self
  end

  def self.seed_create_prof(user, idx, all_images)
    begin
      user.kairos_profile = KairosProfile.create!(user: user, image_url: all_images[idx])
    rescue
      binding.pry
      seed_create_prof(user, idx, all_images)
    end
  end

  def priorities
    dick = ATTRIBUTES.map { |attr| attrib_priority(attr) }
    dick.sort_by{ |pair| pair.values.first }.reverse.map { |pair| pair.keys.first }
  end

  def attrib_priority(attrib)
    {attrib => user.likes.map { |like| like.kairos_profile.send(attrib) }.to_data_collection.remove_outliers.normalize.standard_deviation}
  end

end
