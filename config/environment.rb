require 'rubygems'
require 'bundler'

# Load all default gems and then gems for this env.
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
