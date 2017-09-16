require 'uri_checker'

describe UriChecker do
  before do
    stub_request(:any, 'http://www.valid.com')
    stub_request(:any, 'http://www.requesttimeout.com').to_timeout
  end

  describe '#process_uri' do
    it 'allows a valid http uri to be checked for response' do
      expect(subject).to receive(:check_for_response)
      subject.process_uri('http://validuri.com')
    end

    it 'allows a valid https uri to be checked for response' do
      expect(subject).to receive(:check_for_response)
      subject.process_uri('https://validuri.com')
    end

    it 'does not allow check for response on an invalid uri structure' do
      expect(subject).not_to receive(:check_for_response)
      subject.process_uri('invaliduri.jpg')
    end

    it 'does not allow check for response on a uri with invalid characters' do
      expect(subject).not_to receive(:check_for_response)
      subject.process_uri('http://<>"#`')
    end
  end

  describe '#check_for_response' do
      it 'gets a response from a valid url' do
        res = subject.check_for_response('http://www.valid.com')
        expect(res.status).to include("200")
      end

      it 'raises an error on timeout' do
        expect(subject.check_for_response('http://www.requesttimeout.com')).to eq('timeout')
      end
  end
end
