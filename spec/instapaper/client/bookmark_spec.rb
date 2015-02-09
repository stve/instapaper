require 'spec_helper'

describe Instapaper::Client::Bookmark do
  before(:each) do
    @client = Instapaper::Client.new(:consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
  end

  describe '.bookmarks' do
    before do
      stub_post("bookmarks/list").
        to_return(:body => fixture("bookmarks_list.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.bookmarks
      expect(a_post("bookmarks/list")).
        to have_been_made
    end

    it "should return an array containing bookmarks on success" do
      bookmarks = @client.bookmarks
      expect(bookmarks).to be_an Array
      expect(bookmarks.size).to eq(2)
    end

    it "should remove the meta and current user objects from the array" do
      bookmarks = @client.bookmarks
      bookmarks.each do |bookmark|
        expect(bookmark).to be_a Hashie::Rash
        expect(bookmark.type).to eq('bookmark')
      end
    end
  end

  describe '.update_read_progress' do
    before do
      @time = Time.now
      stub_post("bookmarks/update_read_progress").
        to_return(:body => fixture("bookmarks_update_read_progress.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.update_read_progress(123, 0.5, @time)
      expect(a_post("bookmarks/update_read_progress").with(:body => {:bookmark_id => "123", :progress => '0.5', :progress_timestamp => @time.to_i.to_s })).
        to have_been_made
    end

    it "should return an array containing bookmarks on success" do
      bookmark = @client.update_read_progress(123, 0.5, @time)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
      expect(bookmark.progress).to eq("0.5")
    end
  end

  describe '.add_bookmark' do
    before do
      stub_post("bookmarks/add").
        to_return(:body => fixture('bookmarks_add.json'), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.add_bookmark('http://someurl.com', :title => 'This is the title', :description => 'This is the description')
      expect(a_post("bookmarks/add").with(:body => {:url => "http://someurl.com", :title => 'This is the title', :description => 'This is the description' })).
        to have_been_made
    end

    it "should return the bookmark on success" do
      bookmark = @client.add_bookmark('http://someurl.com', :title => 'This is the title', :description => 'This is the description')
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
    end
  end

  describe '.delete_bookmark' do
    before do
      stub_post("bookmarks/delete").
        to_return(:body => '[]', :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.delete_bookmark(123)
      expect(a_post("bookmarks/delete").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return an array containing bookmarks on success" do
      confirm = @client.delete_bookmark(123)
      expect(confirm).to be_an Array
      expect(confirm).to be_empty
    end
  end

  describe '.star' do
    before do
      stub_post("bookmarks/star").
        to_return(:body => fixture("bookmarks_star.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.star(123)
      expect(a_post("bookmarks/star").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return a starred bookmark on success" do
      bookmark = @client.star(123)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
      expect(bookmark.starred).to eq('1')
    end

    it 'should be aliased as .star_bookmark' do
      expect(@client.star(123)).to eq(@client.star_bookmark(123))
    end
  end

  describe '.unstar' do
    before do
      stub_post("bookmarks/unstar").
        to_return(:body => fixture("bookmarks_unstar.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.unstar(123)
      expect(a_post("bookmarks/unstar").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return an unstarred bookmark on success" do
      bookmark = @client.unstar(123)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
      expect(bookmark.starred).to eq('0')
    end

    it 'should be aliased as .unstar_bookmark' do
      expect(@client.unstar(123)).to eq(@client.unstar_bookmark(123))
    end
  end

  describe '.archive' do
    before do
      stub_post("bookmarks/archive").
        to_return(:body => fixture("bookmarks_archive.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.archive(123)
      expect(a_post("bookmarks/archive").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return the bookmark on success" do
      bookmark = @client.archive(123)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
    end

    it 'should be aliased as .archive_bookmark' do
      expect(@client.archive(123)).to eq(@client.archive_bookmark(123))
    end
  end

  describe '.unarchive' do
    before do
      stub_post("bookmarks/unarchive").
        to_return(:body => fixture("bookmarks_unarchive.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.unarchive(123)
      expect(a_post("bookmarks/unarchive").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return the bookmark on success" do
      bookmark = @client.unarchive(123)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
    end

    it 'should be aliased as .unarchive_bookmark' do
      expect(@client.unarchive(123)).to eq(@client.unarchive_bookmark(123))
    end
  end

  describe '.move' do
    before do
      stub_post("bookmarks/move").
        to_return(:body => fixture("bookmarks_move.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.move(123, 12345)
      expect(a_post("bookmarks/move").with(:body => {:bookmark_id => "123", :folder_id => "12345" })).
        to have_been_made
    end

    it "should return the bookmark on success" do
      bookmark = @client.move(123, 12345)
      expect(bookmark).to be_a Hashie::Rash
      expect(bookmark.type).to eq('bookmark')
    end

    it 'should be aliased as .move_bookmark' do
      expect(@client.move(123, 12345)).to eq(@client.move_bookmark(123, 12345))
    end
  end

  describe '.text' do
    before do
      stub_post("bookmarks/get_text").
        to_return(:body => fixture("bookmarks_get_text.txt"), :headers => {:content_type => "text/html; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.text(123)
      expect(a_post("bookmarks/get_text").with(:body => {:bookmark_id => "123" })).
        to have_been_made
    end

    it "should return the bookmark's html on success" do
      bookmark = @client.text(123)
      expect(bookmark.length).to be > 0
      expect(bookmark).to include("Ideo's Axioms for Starting Disruptive New Businesses")
    end

    it 'should be aliased as .get_text' do
      expect(@client.text(123)).to eq(@client.get_text(123))
    end
  end

end
