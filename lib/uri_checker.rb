class UriChecker
  require 'uri'
  require 'net/http'

  def check_for_response(uri)
    Net::HTTP.get_response(URI.parse(uri))
  end

  def is_valid_uri?(uri)
    uri =~ /\A#{URI::regexp(['http', 'https'])}\z/ ? true : false
  end
end
