require 'active_record'
require 'pry'
require 'pry-byebug'
require 'bundler/setup'
Bundler.require
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'murasaki_shikibu'
