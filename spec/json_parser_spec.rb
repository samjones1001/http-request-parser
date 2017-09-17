require 'json_parser'

describe JsonParser do
  describe '#create_response_json' do

    it 'returns a json object with the correct fields' do
      headers = {
        "server"=>"Apache/2.4.7 (Ubuntu)",
        "last-modified"=>"Sat, 16 Sep 2017 08:30:33 GMT",
        "content-type"=>"text/html",
        "vary"=>"Accept-Encoding",
        "cache-control"=>"max-age=14350",
        "expires"=>"Sat, 16 Sep 2017 17:52:48 GMT",
        "date"=>"Sat, 16 Sep 2017 13:53:38 GMT",
        "content-length"=>"3000",
        "connection"=>"keep-alive"
      }
      expected_output = %({\n\s\s"url": "http://example.com",\n\s\s"status_code": 200,\n\s\s"content_length": 3000,\n\s\s"date": "Sat, 16 Sep 2017 13:53:38 GMT"\n}\n)
      expect{ subject.create_response_json('http://example.com', 200, headers) }.to  output(expected_output).to_stdout
    end
  end

  describe '#create_error_json' do
    it 'returns a json object describing the error' do
      expected_output = %({\n\s\s"url": "example.com",\n\s\s"error": "invalid url"\n}\n)
      expect{ subject.create_error_json('example.com', 'invalid url') }.to output(expected_output).to_stdout
    end
  end
end
