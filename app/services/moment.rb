class Moment

  def self.headers(options={})
    h = {
      "app_id" => ENV['KAIROS_APP_ID'],
      "app_key" => ENV['KAIROS_APP_SECRET'],
    }
    h.merge("Content-Type" => 'application/json') if options[:json]
    h
  end

  def self.detect_faces(pic_url)
      body = {
        "image" => pic_url,
        "selector" => "FRONTAL"
      }.to_json
    HTTParty.post("https://api.kairos.com/detect", headers: headers(json: true), body: body).parsed_response
  end

  def self.post_emotions(pic_url)
    headers = {
      "app_id" => ENV['KAIROS_APP_ID'],
      "app_key" => ENV['KAIROS_APP_SECRET']
    }
    body = {
      "source" => pic_url,
      "timeout" => 60
    }
    HTTParty.post("https://api.kairos.com/v2/media", query: body, headers: headers, body: body.to_json).parsed_response
  end

  def self.get_emotions(id)
    HTTParty.get("https://api.kairos.com/v2/media/#{id}", headers: headers).parsed_response
  end

  def self.get_all(pic_url)
    {
      detect: detect_faces(pic_url),
      emotions: post_emotions(pic_url)
    }
  end

end
