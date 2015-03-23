require 'spec_helper'

RSpec.describe RepoParser do
  before do
    # stub all requests to the URI
    stub = File.open('spec/fixtures/repositories.response')
    stub_request(:get, 'https://api.github.com/repositories').to_return(stub)
  end

  let(:result) do
    described_class.run
  end

  it 'returns a list of repositories' do
    repositories = result.repositories
    expect(repositories).to be_an(Array)

    repo = repositories.first
    expect(repo.name).to be_present
    expect(repo.owner).to be_present
    expect(repo.url).to be_present
  end

  it 'returns the repositories ordered by owner' do
    repositories = result.repositories

    owners = repositories.map(&:owner)

    expect(owners).to eq owners.sort
  end

  it 'returns only ruby repositories' do
    repositories = result.repositories

    names = repositories.map(&:name)
    ruby_names = names.select do |name|
      name =~ /ruby/i
    end

    expect(ruby_names).to eq names
  end

  it 'returns only non-forked repositories' do
    repositories = result.repositories

    forked = repositories.select(&:fork)

    expect(forked).to be_empty
  end
end
