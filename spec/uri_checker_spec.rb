require 'uri_checker'

describe UriChecker do
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
