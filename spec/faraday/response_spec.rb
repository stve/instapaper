require 'spec_helper'

describe Faraday::Response do
  before do
    @client = Instapaper::Client.new
  end

  [1040, 1041, 1042, 1220, 1221, 1240, 1241, 1242, 1243, 1244, 1245, 1250,
   1251, 1252, 1500, 1550].each do |status|
    context "when HTTP status is #{status}" do
      before do
        stub_post('/api/1/folders/list').to_return(status: status)
      end

      it 'should raise Instapaper::Error error' do
        expect do
          @client.folders
        end.to raise_error(Instapaper::Error)
      end
    end
  end
end
