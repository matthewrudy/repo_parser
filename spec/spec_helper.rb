$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'repo_parser'
require 'webmock/rspec'

RSpec.configure(&:disable_monkey_patching!)

RSpec::Matchers.define :be_present do
  match do |actual|
    !actual.nil? && actual.length > 0
  end
end
