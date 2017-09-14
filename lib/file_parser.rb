class FileParser

  def parse(file)
    text = file.read
    text.split("\n")
  end

end
