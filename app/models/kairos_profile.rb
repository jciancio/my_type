class KairosProfile < ApplicationRecord
  belongs_to :user
  before_save :set_attribs

  def data
    @data ||= Facey.new(image_url)
  end

  def set_attribs
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

end
