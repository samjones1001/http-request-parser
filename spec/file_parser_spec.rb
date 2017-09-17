require 'file_parser'

describe FileParser do
  let (:file)   { "./assets/example.txt" }

  describe '#parse' do
    it 'returns an array' do
      expect(subject.parse(file)).to be_an_instance_of(Array)
    end

    it 'retains the content of the file' do
      expect(subject.parse(file)).to include("https://google.com")
    end

    it 'retains all lines of the file' do
      expect(subject.parse(file).size).to eq(9)
    end
  end
end
