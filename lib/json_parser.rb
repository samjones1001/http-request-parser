require 'json'

class JsonParser
  def create_response_json(url, status, headers)
    response_json = JSON.pretty_generate({
      'url' => url,
      'status_code' => status,
      'content_length' => headers.meta['content-length'].to_i,
      'date' => headers.meta['date']
    })
    pretty_print(response_json)
  end

  def create_error_json(url, message)
    error_json = JSON.pretty_generate({
      'url' => url,
      'error' => message
    })
    pretty_print(error_json)
  end

  def pretty_print(json)
    puts json
  end
end
