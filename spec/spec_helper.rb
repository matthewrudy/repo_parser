$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'resume'

RSpec::Matchers.define :be_present do
  match do |actual|
    !actual.nil? && actual.length > 0
  end
end
