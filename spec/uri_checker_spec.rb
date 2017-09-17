require 'uri_checker'

describe UriChecker do
  let(:file_parser)  { double :file_parser }
  let(:json_parser)  { double :json_parser }
  let(:subejct)      { described_class.new(file_parser, json_parser) }

  before do
    ARGV[0] = "./spec/test_file.txt"
    stub_request(:any, 'http://www.valid.com')
    stub_request(:any, 'http://www.requesttimeout.com').to_timeout
    stub_request(:any, 'http://www.404error.com').to_return(status: 404)
  end

  it 'holds an instance of FileParser by default' do
    expect(subject.file_parser).to be_an_instance_of(FileParser)
  end

  it 'holds an instance of JsonParser by default' do
    expect(subject.json_parser).to be_an_instance_of(JsonParser)
  end

  it 'holds an array of uris' do
    expect(subject.uri_array).to be_an_instance_of(Array)
  end

  it 'processes each uri at initialization' do
    expect_any_instance_of(UriChecker).to receive(:process_uri).exactly(2).times
    UriChecker.new
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
      expect(subject.json_parser).to receive(:create_error_json)
      subject.process_uri('invaliduri.jpg')
    end

    it 'does not allow check for response on a uri with invalid characters' do
      expect(subject).not_to receive(:check_for_response)
      expect(subject.json_parser).to receive(:create_error_json)
      subject.process_uri('http://<>"#`')
    end
  end

  describe '#check_for_response' do
      it 'gets a response from a valid url' do
        expect(subject.json_parser).to receive(:create_response_json)
        subject.check_for_response('http://www.valid.com')
      end

      it 'gets a response from a uri which returns a http error code' do
        expect(subject.json_parser).to receive(:create_response_json)
        subject.check_for_response('http://www.404error.com')
      end

      it 'creates an error on timeout' do
        expect(subject.json_parser).to receive(:create_error_json)
        subject.check_for_response('http://www.requesttimeout.com')
      end
  end
end
