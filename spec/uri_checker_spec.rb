require 'uri_checker'

describe UriChecker do
  before do
    stub_request(:any, "http://www.example.com")
  end

  describe '#check_for_response' do
      it 'gets a response from a valid url' do
        expect(subject.check_for_response('http://www.example.com')).to be_an_instance_of(Net::HTTPOK)
      end
  end

  describe '#is_valid_uri?' do
    it 'returns true if provided with a valid http uri' do
      expect(subject.is_valid_uri?('http://validuri.com')).to be(true)
    end

    it 'returns true if provided with a valid https uri' do
      expect(subject.is_valid_uri?('https://validuri.com')).to be(true)
    end

    it 'returns false if provided with an invalid uri structure' do
      expect(subject.is_valid_uri?('invaliduri.jpg')).to be(false)
    end

    it 'returns false if provided with a uri with invalid characters' do
      expect(subject.is_valid_uri?('http://<>"#`')).to be(false)
    end
  end
end
