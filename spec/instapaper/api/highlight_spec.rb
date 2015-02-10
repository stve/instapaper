require 'spec_helper'

describe Instapaper::Client::Highlight do
  let(:client) { Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', oauth_token: 'OT', oauth_token_secret: 'OS') }

  describe '#highlights' do
    before do
      stub_post('/api/1.1/bookmarks/123/highlights')
        .to_return(status: 200, body: fixture('highlights_list.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'should get the correct resource' do
      client.highlights(123)
      expect(a_post('/api/1.1/bookmarks/123/highlights')).to have_been_made
    end

    it 'should return an array containing folders on success' do
      highlights = client.highlights(123)
      expect(highlights).to be_an Array
      expect(highlights.size).to eq(2)
      expect(highlights.first).to be_an Instapaper::Highlight
    end
  end

  describe '#highlight' do
    before do
      stub_post('/api/1.1/bookmarks/123/highlight')
        .to_return(status: 200, body: fixture('highlight.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'should get the correct resource' do
      client.highlight(123, text: 'This is the highlighted text.', position: 22)
      expect(a_post('/api/1.1/bookmarks/123/highlight')).to have_been_made
    end

    it 'should return an array containing folders on success' do
      highlight = client.highlight(123, text: 'This is the highlighted text.', position: 22)
      expect(highlight).to be_an Instapaper::Highlight
    end
  end

  describe '#delete_highlight' do
    before do
      stub_post('/api/1.1/highlights/123/delete')
        .to_return(status: 200, body: '', headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'should post to the correct resource' do
      client.delete_highlight(123)
      expect(a_post('/api/1.1/highlights/123/delete')).to have_been_made
    end

    it 'should return true when successful' do
      response = client.delete_highlight(123)
      expect(response).to be true
    end
  end
end
