require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/spec/'
end
SimpleCov.minimum_coverage 90
