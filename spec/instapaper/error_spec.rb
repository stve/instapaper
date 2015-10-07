require 'spec_helper'

describe Instapaper::Error do
  before do
    @client = Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', oauth_token: 'AT', oauth_token_secret: 'AS')
  end

  describe '#code' do
    it 'returns the error code' do
      error = Instapaper::Error.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = Instapaper::Error.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end

  Instapaper::Error::ERRORS.each do |status, exception|
    context "when HTTP status is #{status}" do
      let(:response_body) { %([{"type":"error", "error_code":#{status}, "message":"Error Message"}]) }
      before do
        stub_post('/api/1.1/oauth/access_token')
          .to_return(status: 200, body: response_body, headers: {content_type: 'application/json; charset=utf-8'})
      end
      it "raises #{exception}" do
        expect { @client.access_token('foo', 'bar') }.to raise_error(Instapaper::Error)
      end
    end
  end

  Instapaper::Error::BOOKMARK_ERRORS.each do |status, exception|
    context "when HTTP status is #{status}" do
      let(:response_body) { %([{"type":"error", "error_code":#{status}, "message":"Error Message"}]) }
      before do
        stub_post('/api/1.1/bookmarks/list')
          .to_return(status: 200, body: response_body, headers: {content_type: 'application/json; charset=utf-8'})
      end
      it "raises #{exception}" do
        expect { @client.bookmarks }.to raise_error(Instapaper::Error::BookmarkError)
      end
    end
  end

  Instapaper::Error::FOLDER_ERRORS.each do |status, exception|
    context "when HTTP status is #{status}" do
      let(:response_body) { %([{"type":"error", "error_code":#{status}, "message":"Error Message"}]) }
      before do
        stub_post('/api/1.1/folders/list')
          .to_return(status: 200, body: response_body, headers: {content_type: 'application/json; charset=utf-8'})
      end
      it "raises #{exception}" do
        expect { @client.folders }.to raise_error(Instapaper::Error::FolderError)
      end
    end
  end

  Instapaper::Error::HIGHLIGHT_ERRORS.each do |status, exception|
    context "when HTTP status is #{status}" do
      let(:response_body) { %([{"type":"error", "error_code":#{status}, "message":"Error Message"}]) }
      before do
        stub_get('/api/1.1/bookmarks/123/highlights')
          .to_return(status: 200, body: response_body, headers: {content_type: 'application/json; charset=utf-8'})
      end
      it "raises #{exception}" do
        expect { @client.highlights('123') }.to raise_error(Instapaper::Error::HighlightError)
      end
    end
  end
end
