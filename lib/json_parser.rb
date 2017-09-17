require 'json'

class JsonParser
  def create_response_json(url, status, headers)
    response_json = {
      'url' => url,
      'status_code' => status,
      'content_length' => headers['content-length'].to_i,
      'date' => headers['date']
    }.to_json
  end

  def create_error_json(url, message)
    error_json = {
      'url' => url,
      'error' => message
    }.to_json
  end
end
