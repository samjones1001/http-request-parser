class UriChecker

  def is_valid_uri?(uri)
    valid_structure = Regexp.new(/^https?:\/\/\w+.\w+(\.\w+)?/)
    uri =~ valid_structure ? true : false
  end
end
