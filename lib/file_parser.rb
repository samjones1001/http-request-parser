class FileParser

  def parse(file)
    text = open(file).read
    text.split("\n")
  end

end
