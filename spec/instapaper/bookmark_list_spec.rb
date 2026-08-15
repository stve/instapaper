require 'spec_helper'

describe Instapaper::BookmarkList do
  describe '#each' do
    it 'yields a list of bookmarks' do
      list = described_class.new(JSON.parse(fixture('bookmarks_list.json').read))
      expect(list).to all(be_an Instapaper::Bookmark)
    end
  end
end
