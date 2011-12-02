require 'spec_helper'

describe Instapaper::Client::Folder do
  before(:each) do
    @client = Instapaper::Client.new
  end

  describe '.folders' do
    before do
      stub_post("folders/list").
        to_return(:body => fixture("folders_list.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.folders
      a_post("folders/list").
        should have_been_made
    end

    it "should return an array containing folders on success" do
      folders = @client.folders
      folders.should be_an Array
      folders.size.should == 2
      folders.first.should be_a Hashie::Rash
      folders.first['title'].should == 'Ruby'
    end
  end

  describe '.add_folder' do
    before do
      stub_post("folders/add").with(:body => {:title => "Ruby" }).
        to_return(:body => fixture("folders_add.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.add_folder("Ruby")
      a_post("folders/add").
        should have_been_made
    end

    it "should return an array containing the new folder on success" do
      folders = @client.add_folder("Ruby")
      folders.should be_an Array
      folders.should_not be_empty
      folders.first.should be_a Hashie::Rash
      folders.first['title'].should == 'Ruby'
    end
  end

  describe '.delete_folder' do
    before do
      stub_post("folders/delete"). with(:body => {:folder_id => "1" }).
        to_return(:body => fixture("folders_delete.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.delete_folder("1")
      a_post("folders/delete").
        should have_been_made
    end

    it "should return an empty array on success" do
      confirm = @client.delete_folder("1")
      confirm.should be_an Array
      confirm.should be_empty
    end
  end

  describe '.set_order' do
    before do
      stub_post("folders/set_order"). with(:body => {:order => "1121173:2,1121174:1" }).
        to_return(:body => fixture("folders_set_order.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.set_order(['1121173:2','1121174:1'])
      a_post("folders/set_order").
        should have_been_made
    end

    it "should return an array reflecting the new order on success" do
      folders = @client.set_order(['1121173:2','1121174:1'])
      folders.should be_an Array
      folders.first.should be_a Hashie::Rash
      folders.first['position'].should == 1
    end
  end

end