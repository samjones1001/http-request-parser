class UriChecker
  require 'uri'
  require 'net/http'
  require 'open-uri'

  def process_uri(uri)
    check_for_response(uri) if is_valid_uri?(uri)
  end

  def check_for_response(uri)
    begin
      Timeout.timeout(5) { open(uri) }
    rescue
      'timeout'
    end
  end

  private
  def is_valid_uri?(uri)
    uri =~ /\A#{URI::regexp(['http', 'https'])}\z/ ? true : false
  end
end
