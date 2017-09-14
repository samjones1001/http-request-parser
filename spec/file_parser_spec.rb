require 'file_parser'

describe FileParser do
  let (:file)   { double :File }
  describe '#parse' do
    it 'returns an array' do
      expect(subject.parse(file)).to be_an_instance_of(Array)
    end
  end
end
