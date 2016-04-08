require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] ||= 'test'
# require File.expand_path('../../config/environment', __FILE__)
require 'minitest'
require 'rack/test'
reporter_options = { color: true, slow_count: 5 }
# Optional slow_threshold
# reporter_options = { color: true, slow_count: 5, slow_threshold: 0.01 }
# * https://github.com/kern/minitest-reporters
# * http://chriskottom.com/blog/2014/06/dress-up-your-minitest-output/
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
