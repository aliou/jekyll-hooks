require 'spec_helper'
require 'rack/test'

require './hooks'

RSpec.describe Hooks do
  def app
    Hooks.new
  end

  describe 'POST /' do
    context 'when the data is not valid' do
      it 'returns a 500' do
        post '/', '{}'
        expect(last_response.status).to eq(500)
      end
    end

    context 'when the data is valid' do
      it 'returns a 200' do
        raw_data = File.read('./spec/fixtures/push_event.json')
        data = JSON(raw_data)
        repo_name = data.fetch('repository').fetch('name')

        expect(Builder).to receive(:new).and_return(Builder.new(
          repo_name,
          'spec/fixtures/config_sites.json',
          "#{ ENV['PWD'] }/spect/fixtures")
        )

        post '/', raw_data
        expect(last_response.status).to eq(200)
      end
    end
  end
end
