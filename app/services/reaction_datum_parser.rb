class ReactionDatumParser
  attr_accessor :frames, :anger, :disgust, :fear, :joy, :sadness, :surprise, :ppl_count, :frames_count

  def initialize(frames)
    @frames = frames
    @frames_count = frames.size
    @ppl_count = count_people
    @anger = @disgust = @fear = @joy = @sadness = @surprise = 0
    parse
  end

  def count_people
    frames.map do |f|
      s = f[:people].size
      s > 0 ? s : 1
    end.reduce(:+) / frames_count
  end

  def prepare
    {
      anger: self.anger,
      disgust: self.disgust,
      fear: self.fear,
      joy: self.joy,
      sadness: self.sadness,
      surprise: self.surprise
    }
  end

  def parse
    until frames.empty?
      parse_frame(frames.pop)
    end
    avg(:frames_count)
  end

  def parse_frame(frame)
    until frame[:people].empty?
      parse_person(frame[:people].pop)
      avg(:ppl_count)
    end
  end

  def parse_person(person)
    self.anger += person[:emotions][:anger]
    self.disgust += person[:emotions][:disgust]
    self.fear += person[:emotions][:fear]
    self.joy += person[:emotions][:joy]
    self.sadness += person[:emotions][:sadness]
    self.surprise += person[:emotions][:surprise]
  end

  def avg(attr)
    self.anger /= self.send(attr.to_sym)
    self.disgust /= self.send(attr.to_sym)
    self.fear /= self.send(attr.to_sym)
    self.joy /= self.send(attr.to_sym)
    self.sadness /= self.send(attr.to_sym)
    self.surprise /= self.send(attr.to_sym)
  end
end
