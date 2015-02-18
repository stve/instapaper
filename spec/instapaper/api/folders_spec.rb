require 'spec_helper'

describe Instapaper::Client::Folders do
  let(:client) { Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', oauth_token: 'OT', oauth_token_secret: 'OS') }

  describe '#folders' do
    before do
      stub_post('/api/1/folders/list')
        .to_return(body: fixture('folders_list.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.folders
      expect(a_post('/api/1/folders/list'))
        .to have_been_made
    end

    it 'returns an array containing folders on success' do
      folders = client.folders
      expect(folders).to be_an Array
      expect(folders.size).to eq(2)
      expect(folders.first).to be_a Instapaper::Folder
    end
  end

  describe '#add_folder' do
    before do
      stub_post('/api/1/folders/add').with(body: {title: 'Ruby'})
        .to_return(body: fixture('folders_add.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.add_folder('Ruby')
      expect(a_post('/api/1/folders/add'))
        .to have_been_made
    end

    it 'returns an array containing the new folder on success' do
      folder = client.add_folder('Ruby')
      expect(folder).to be_a Instapaper::Folder
    end
  end

  describe '#delete_folder' do
    before do
      stub_post('/api/1/folders/delete'). with(body: {folder_id: '1'})
        .to_return(body: fixture('folders_delete.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.delete_folder('1')
      expect(a_post('/api/1/folders/delete'))
        .to have_been_made
    end

    it 'returns an empty array on success' do
      confirm = client.delete_folder('1')
      expect(confirm).to be true
    end
  end

  describe '#set_order' do
    before do
      stub_post('/api/1/folders/set_order'). with(body: {order: '1121173:2,1121174:1'})
        .to_return(body: fixture('folders_set_order.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.set_order(['1121173:2', '1121174:1'])
      expect(a_post('/api/1/folders/set_order'))
        .to have_been_made
    end

    it 'returns an array reflecting the new order on success' do
      folders = client.set_order(['1121173:2', '1121174:1'])
      expect(folders).to be_an Array
      expect(folders.first).to be_a Instapaper::Folder
    end
  end
end
