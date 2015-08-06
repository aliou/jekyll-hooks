require 'forwardable'

class SiteConfig
  extend Forwardable

  DEFAULT_CONFIG_FILE = 'config/sites.json'

  attr_reader :data
  attr_reader :config_file

  def_delegators :data, :fetch

  def initialize(config_file = nil)
    @config_file = config_file.nil? ? DEFAULT_CONFIG_FILE : config_file

    @data = JSON(File.read(@config_file))
  end
end
