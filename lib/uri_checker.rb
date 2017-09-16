class UriChecker
  require 'uri'
  require 'net/http'
  require 'open-uri'

  def check_for_response(uri)
    begin
      Timeout.timeout(5) { open(uri) }
    rescue
      'timeout'
    end
  end


  def is_valid_uri?(uri)
    uri =~ /\A#{URI::regexp(['http', 'https'])}\z/ ? true : false
  end
end
