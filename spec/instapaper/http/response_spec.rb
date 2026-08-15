require 'spec_helper'

class FakeResponse
  FakeStatus = Struct.new(:code) do
    def ok?
      code == 200
    end
  end

  def initialize(body, code = 200)
    @body = body
    @code = code
  end

  def parse(_)
    ::JSON.parse(@body)
  end

  def status
    FakeStatus.new(@code)
  end
end

describe Instapaper::HTTP::Response do
  describe '#body' do
    context 'when the API returns a raw response' do
      it 'returns the response in raw text' do
        resp = described_class.new('foo', '', true)
        expect(resp.body).to eq('foo')
      end
    end

    context 'when the API returns a regular response' do
      let(:fake_response) { FakeResponse.new('{"foo":"bar"}') }

      it 'returns the parsed response' do
        resp = described_class.new(fake_response, '')
        expect(resp.body).to be_a(Hash)
      end
    end
  end

  describe '#valid?' do
    context 'when response is valid' do
      let(:fake_response) { FakeResponse.new('{"foo":"bar"}') }

      it 'returns true' do
        resp = described_class.new(fake_response, '')
        expect(resp.valid?).to be(true)
      end
    end

    context 'when http error' do
      context 'with a known error code' do
        let(:fake_response) { FakeResponse.new('{"foo":"bar"}', 503) }

        it 'raises the matching error' do
          resp = described_class.new(fake_response, '')
          expect { resp.valid? }.to raise_error(Instapaper::Error::ServerError)
        end
      end

      context 'with an unknown error code' do
        let(:fake_response) { FakeResponse.new('{"foo":"bar"}', 418) }

        it 'raises a generic error' do
          resp = described_class.new(fake_response, '')
          expect { resp.valid? }.to raise_error(Instapaper::Error, 'Unknown Error')
        end
      end
    end

    context 'when body unparseable' do
      let(:fake_response) { FakeResponse.new('{"key":"value}') }

      it 'raises a ServiceUnavailableError' do
        resp = described_class.new(fake_response, '')
        expect { resp.valid? }.to raise_error(Instapaper::Error::ServiceUnavailableError)
      end
    end

    context 'when error in body' do
      context 'with a generic service error' do
        let(:fake_response) { FakeResponse.new('[{"type":"error","error_code":1040}]') }

        it 'raises the matching error' do
          resp = described_class.new(fake_response, '')
          expect { resp.valid? }.to raise_error(Instapaper::Error) { |error| expect(error.code).to eq(1040) }
        end
      end

      context 'with a namespaced error' do
        let(:fake_response) { FakeResponse.new('[{"type":"error","error_code":1240}]') }

        it 'raises the matching namespaced error' do
          resp = described_class.new(fake_response, '/api/1.1/bookmarks/add')
          expect { resp.valid? }.to raise_error(Instapaper::Error::BookmarkError)
        end
      end
    end
  end
end
