class UriChecker
  require 'net/http'
  require 'open-uri'

  attr_reader :file_parser, :json_parser, :uri_array

  def initialize(file_parser = FileParser.new, json_parser = JsonParser.new)
    @file_parser = file_parser
    @json_parser = json_parser
    @uri_array = file_parser.parse(ARGV.first)
    uri_array.each { |uri| process_uri(uri) }
  end

  def process_uri(uri)
    is_valid_uri?(uri) ? check_for_response(uri) : @json_parser.create_error_json(uri, "invalid url")
  end

  def check_for_response(uri)
    begin
      Timeout.timeout(10) do
        res = open(uri)
        @json_parser.create_response_json(uri, res.status[0], res.meta)
      end
    rescue OpenURI::HTTPError => the_error
      status = the_error.io.status[0]
      headers = the_error.io.meta
      @json_parser.create_response_json(uri, status, headers)
    rescue
      @json_parser.create_error_json(uri, "connection timed out")
    end

  end

  private

  def is_valid_uri?(uri)
    uri =~ /\A#{URI::regexp(['http', 'https'])}\z/ ? true : false
  end
end
