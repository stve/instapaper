require 'spec_helper'

describe Instapaper::Client::Bookmarks do
  let(:client) { Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', oauth_token: 'OT', oauth_token_secret: 'OS') }

  describe '#bookmarks' do
    before do
      stub_post('/api/1.1/bookmarks/list')
        .to_return(body: fixture('bookmarks_list.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.bookmarks
      expect(a_post('/api/1.1/bookmarks/list'))
        .to have_been_made
    end

    it 'returns an Instapaper::BookmarkList on success' do
      list = client.bookmarks
      expect(list).to be_an Instapaper::BookmarkList
    end

    it 'includes all objects in the response' do
      list = client.bookmarks
      expect(list.user).to be_an Instapaper::User
      list.bookmarks.each do |bookmark|
        expect(bookmark).to be_an Instapaper::Bookmark
      end
    end
  end

  describe '#update_read_progress' do
    before do
      @time = Time.now
      stub_post('/api/1.1/bookmarks/update_read_progress')
        .to_return(body: fixture('bookmarks_update_read_progress.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.update_read_progress(123, 0.5, @time)
      expect(a_post('/api/1.1/bookmarks/update_read_progress').with(body: {bookmark_id: '123', progress: '0.5', progress_timestamp: @time.to_i.to_s}))
        .to have_been_made
    end

    it 'returns an array containing bookmarks on success' do
      bookmark = client.update_read_progress(123, 0.5, @time)
      expect(bookmark).to be_an Instapaper::Bookmark
      expect(bookmark.progress).to eq('0.5')
    end
  end

  describe '#add_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/add')
        .to_return(body: fixture('bookmarks_add.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.add_bookmark('http://someurl.com', title: 'This is the title', description: 'This is the description')
      expect(a_post('/api/1.1/bookmarks/add').with(body: {url: 'http://someurl.com', title: 'This is the title', description: 'This is the description'}))
        .to have_been_made
    end

    it 'returns the bookmark on success' do
      bookmark = client.add_bookmark('http://someurl.com', title: 'This is the title', description: 'This is the description')
      expect(bookmark).to be_an Instapaper::Bookmark
    end
  end

  describe '#delete_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/delete')
        .to_return(body: '[]', headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.delete_bookmark(123)
      expect(a_post('/api/1.1/bookmarks/delete').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it 'returns an array containing bookmarks on success' do
      confirm = client.delete_bookmark(123)
      expect(confirm).to be_an Array
      expect(confirm).to be_empty
    end
  end

  describe '#star_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/star')
        .to_return(body: fixture('bookmarks_star.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.star_bookmark(123)
      expect(a_post('/api/1.1/bookmarks/star').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it 'returns a starred bookmark on success' do
      bookmark = client.star_bookmark(123)
      expect(bookmark).to be_an Instapaper::Bookmark
      expect(bookmark.starred).to eq('1')
    end
  end

  describe '#unstar_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/unstar')
        .to_return(body: fixture('bookmarks_unstar.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.unstar_bookmark(123)
      expect(a_post('/api/1.1/bookmarks/unstar').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it 'returns an unstarred bookmark on success' do
      bookmark = client.unstar_bookmark(123)
      expect(bookmark).to be_an Instapaper::Bookmark
      expect(bookmark.starred).to eq('0')
    end
  end

  describe '#archive_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/archive')
        .to_return(body: fixture('bookmarks_archive.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.archive_bookmark(123)
      expect(a_post('/api/1.1/bookmarks/archive').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it 'returns the bookmark on success' do
      bookmark = client.archive_bookmark(123)
      expect(bookmark).to be_an Instapaper::Bookmark
    end
  end

  describe '#unarchive_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/unarchive')
        .to_return(body: fixture('bookmarks_unarchive.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.unarchive_bookmark(123)
      expect(a_post('/api/1.1/bookmarks/unarchive').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it 'returns the bookmark on success' do
      bookmark = client.unarchive_bookmark(123)
      expect(bookmark).to be_an Instapaper::Bookmark
    end
  end

  describe '#move_bookmark' do
    before do
      stub_post('/api/1.1/bookmarks/move')
        .to_return(body: fixture('bookmarks_move.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.move_bookmark(123, 12_345)
      expect(a_post('/api/1.1/bookmarks/move').with(body: {bookmark_id: '123', folder_id: '12345'}))
        .to have_been_made
    end

    it 'returns the bookmark on success' do
      bookmark = client.move_bookmark(123, 12_345)
      expect(bookmark).to be_an Instapaper::Bookmark
    end
  end

  describe '#get_text' do
    before do
      stub_post('/api/1.1/bookmarks/get_text')
        .to_return(body: fixture('bookmarks_get_text.txt'), headers: {content_type: 'text/html; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.get_text(123)
      expect(a_post('/api/1.1/bookmarks/get_text').with(body: {bookmark_id: '123'}))
        .to have_been_made
    end

    it "returns the bookmark's html on success" do
      bookmark = client.get_text(123)
      expect(bookmark.length).to be > 0
      expect(bookmark).to include("Ideo's Axioms for Starting Disruptive New Businesses")
    end
  end
end
