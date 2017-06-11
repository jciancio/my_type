class ReactionDatum < ApplicationRecord
  belongs_to :user_like

  def analyze
    neg = ['anger', 'disgust', 'fear', 'sadness'].map do |n|
      self.send(n)
    end.reduce(:+)

    pos = ['joy', 'surprise'].map do |n|
      self.send(n)
    end.reduce(:+)

    full = pos + neg

    pos_percent = (pos / full) * 100
    neg_percent = 100 - pos_percent
    {
      positive: pos_percent,
      negative: neg_percent
    }
  end
end
