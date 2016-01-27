require 'spec_helper'

class FakeResponse
  def initialize(body)
    @body = body
  end

  def parse(_)
    ::JSON.parse(@body)
  end
end

describe Instapaper::HTTP::Response do
  describe '#body' do
    context 'raw response' do
      it 'returns the response in raw text' do
        resp = Instapaper::HTTP::Response.new('foo', '', true)
        expect(resp.body).to eq('foo')
      end
    end

    context 'regular response' do
      let(:fake_response) { FakeResponse.new('{"foo":"bar"}') }
      it 'returns the parsed response' do
        resp = Instapaper::HTTP::Response.new(fake_response, '')
        expect(resp.body).to be_a(Hash)
      end
    end
  end

  describe '#valid?' do
    context 'when http error' do
    end

    context 'when body unparseable' do
    end

    context 'when error in body' do
    end
  end
end
