require 'rubygems'
require 'bundler'

# Load all default gems and then gems for this env.
Bundler.require(:default, ENV.fetch('RACK_ENV').to_sym)
