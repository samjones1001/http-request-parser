require 'json'

class JsonParser
  def create_response_json(url, status, headers)
    response_json = JSON.pretty_generate({
      'url' => url,
      'status_code' => status,
      'content_length' => headers['content-length'].to_i,
      'date' => headers['date']
    })
    pretty_print(response_json)
  end

  def create_error_json(url, message)
    error_json = JSON.pretty_generate({
      'url' => url,
      'error' => message
    })
    pretty_print(error_json, true)
  end

  def pretty_print(json, is_error = false)
    is_error ? $stderr.puts(json) : puts(json)
  end
end
