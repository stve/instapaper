require 'spec_helper'

describe Instapaper::BookmarkList do
  describe '#each' do
    it 'yields a list of bookmarks' do
      list = Instapaper::BookmarkList.new(JSON.parse(fixture('bookmarks_list.json').read))
      list.each do |bookmark|
        expect(bookmark).to be_an Instapaper::Bookmark
      end
    end
  end
end
