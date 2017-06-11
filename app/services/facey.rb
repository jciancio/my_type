class Facey

  class TooManyFacesError < StandardError; end
  class NoFacesError < StandardError; end
  class RequestFailedError < StandardError; end

  attr_accessor :url, :face_response, :emotion_response

  def initialize(image_url)
    @url = image_url
    @face_response = get_face_response
    @emotion_response = post_emotion_response
  end

  def dimensions
    @dimensions ||= begin
      dims = face_response[:images][0][:faces][0].select { |k, _| k != 'attributes' }
      dims.merge!(height: face_height, width: face_width)
      OpenStruct.new(dims)
    end
  end

  def image
    face_response[:images].first.select { |k, _| ['status', 'width', 'height', 'file'].include?(k) }.with_indifferent_access
  end

  def chin_to_eye_height
    (dimensions.chinTipY.to_f - eye_height) / face_height
  end

  def eye_width
    dimensions.eyeDistance.to_f / face_width
  end

  def face_proportion
    face_width / face_height
  end

  def face_height
    emotion_response[:frames][0][:people][0][:face][:height].to_f
  end

  def face_width
    emotion_response[:frames][0][:people][0][:face][:width].to_f
  end

  def attributes
    @attributes ||= begin
      attrs = OpenStruct.new(face_response[:images][0][:faces][0][:attributes])
      attrs.gender = OpenStruct.new(attrs.gender)
      attrs
    end
  end

  def gender(options={full: false})
    if options[:full]
      attributes.gender
    else
      attributes.gender.type
    end
  end

  def age
    attributes.age
  end

  def races
    result = ['asian', 'black', 'white', 'other', 'hispanic'].each_with_object({}) do |race, obj|
      obj[race.to_sym] = attributes.send(race)
    end
    OpenStruct.new(result)
  end

  def eye_height
    (dimensions.rightEyeCenterY.to_f + dimensions.leftEyeCenterY) / 2
  end

  def get_face_response
    resp = Moment.detect_faces(url)
    resp = resp.with_indifferent_access
    validate_face!(resp[:images])
    resp
  end

  def poll_emotion_response(id, loops=0)
    puts "Polling..."
    sleep 1
    resp = nil
    while (resp.blank? || resp[:status_message] != 'Complete') && loops < 15
      resp = Moment.get_emotions(id).try(:with_indifferent_access)
        break if resp[:status_message] == 'Complete'
      resp = poll_emotion_response(id, loops + 1)
    end
    resp
  end

  def post_emotion_response
    resp = Moment.post_emotions(url).try(:with_indifferent_access)
    poll_emotion_response(resp[:id])
  end

  def validate_face!(resp)
    if resp.size > 1
      raise TooManyFacesError
    elsif resp.size == 0
      raise NoFacesError
    end
    raise RequestFailedError if resp[0][:status] != "Complete"
  end

end
