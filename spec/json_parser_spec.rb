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
      expected_output = %({"url" : "http://example.com", "status_code" : "200", "content_length" : "3000", "date" : "Sat, 16 Sep 2017 13:53:38 GMT"})
      expect(subject.create_response_json('http://example.com', "200", headers)).to  be_json_eql(expected_output)
    end

  end
end
