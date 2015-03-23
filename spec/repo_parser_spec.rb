require 'spec_helper'

RSpec.describe RepoParser do
  it 'returns a list of repositories' do
    repositories = RepoParser.run.repositories
    expect(repositories).to be_an(Array)

    repo = repositories.first
    expect(repo.name).to be_present
    expect(repo.owner).to be_present
    expect(repo.url).to be_present
  end

  it 'returns the repositories ordered by owner' do
    repositories = RepoParser.run.repositories

    names = repositories.map(&:owner)
    expect(names).to eq names.sort
  end

  it 'returns only ruby repositories' do
    repositories = RepoParser.run.repositories

    names = repositories.map(&:name)
    ruby_names = names.select do |name|
      name =~ /ruby/i
    end

    expect(ruby_names).to eq names
  end

  it 'returns only non-forked repositories' do
    repositories = RepoParser.run.repositories

    forked = repositories.select(&:fork)

    expect(forked).to be_empty
  end
end
