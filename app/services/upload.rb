class Upload
  
  attr_accessor :pic_url
  
  def self.upload(pic_url)
    new(pic_url).upload
  end
  
  def initialize(pic_url)
    @pic_url = pic_url
  end
  
  def upload
    headers = {
      "app_id" => 'f0f771db',
      "app_key" => '1bb0b16630d382b1eaf10e0888997810'
      }
      body = {
        "source" => pic_url
      }
    resp = HTTParty.post("https://api.kairos.com/v2/media", query: body, headers: headers, body: body.to_json).parsed_response
    
  end
  
  private
  
  
  
end