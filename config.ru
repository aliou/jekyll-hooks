require 'rubygems'
require 'bundler'
Bundler.require(:default)

require './hooks'
run Hooks
