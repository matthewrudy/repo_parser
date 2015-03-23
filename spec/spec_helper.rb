$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'repo_parser'

RSpec.configure do |c|
  c.disable_monkey_patching!
end

RSpec::Matchers.define :be_present do
  match do |actual|
    !actual.nil? && actual.length > 0
  end
end
