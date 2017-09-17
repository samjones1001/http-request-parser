require 'json'

class JsonParser
  def create_response_json(url, status, headers)
    response_json = {
      'url' => url,
      'status_code' => status,
      'content_length' => headers['content-length'],
      'date' => headers['date']
    }.to_json
  end
end
