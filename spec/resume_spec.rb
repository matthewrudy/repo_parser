require 'spec_helper'

describe Resume do
  it 'has a version number' do
    expect(Resume::VERSION).not_to be nil
  end

  it 'returns a list of repositories' do
    result = Resume.run
    expect(result).to be_an(Array)

    first = result.first
    expect(first.repo_name).to be_present
    expect(first.owner_name).to be_present
    expect(first.repo_url).to be_present
  end
end
