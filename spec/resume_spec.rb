require 'spec_helper'

RSpec.describe Resume do
  it 'has a version number' do
    expect(Resume::VERSION).not_to be nil
  end

  it 'returns a list of repositories' do
    result = Resume.run
    expect(result).to be_an(Array)

    first = result.first
    expect(first.name).to be_present
    expect(first.owner).to be_present
    expect(first.url).to be_present
  end
end
