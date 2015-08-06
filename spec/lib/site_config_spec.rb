require 'spec_helper'
require './lib/site_config'

RSpec.describe SiteConfig do
  describe '.new' do
    context "when there isn't a config file passed" do
      it 'sets a default config file' do
        expect(SiteConfig.new.config_file).to eq(SiteConfig::DEFAULT_CONFIG_FILE)
      end
    end

    it 'parses the file and stores it' do
      fixture_file = 'spec/fixtures/config_sites.json'
      raw_data = File.read(fixture_file)
      parsed_data = JSON(raw_data)

      config = SiteConfig.new(fixture_file)

      expect(config.data).to eq(parsed_data)
    end
  end

  it 'delegates the fetching to the data' do
    should delegate_method(:fetch).to(:data)
  end
end
