require 'file_parser'

describe FileParser do
  let (:file)   { double :File, :read => "uri_1\nuri_2\nuri_3" }

  describe '#parse' do
    it 'returns an array' do
      expect(subject.parse(file)).to be_an_instance_of(Array)
    end

    it 'retains the content of the file' do
      expect(subject.parse(file)).to include("uri_1")
    end

    it 'reatins all lines of the file' do
      expect(subject.parse(file).size).to eq(3)
    end
  end
end
