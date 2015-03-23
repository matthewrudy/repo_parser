require 'spec_helper'

RSpec.describe Resume do
  it 'has a version number' do
    expect(Resume::VERSION).not_to be nil
  end

  it 'returns a list of repositories' do
    repositories = Resume.run
    expect(repositories).to be_an(Array)

    repo = repositories.first
    expect(repo.name).to be_present
    expect(repo.owner).to be_present
    expect(repo.url).to be_present
  end

  it 'returns the repositories ordered by owner' do
    repositories = Resume.run

    names = repositories.map(&:owner)
    expect(names).to eq names.sort
  end

  it 'returns only ruby repositories' do
    repositories = Resume.run

    names = repositories.map(&:name)
    ruby_names = names.select do |name|
      name =~ /ruby/i
    end

    expect(ruby_names).to eq names
  end
end
