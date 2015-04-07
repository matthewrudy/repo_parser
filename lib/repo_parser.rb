require 'repo_parser/version'
require 'httparty'

# RepoParser is a coding test
# involving scraping some github json,
# and sorting it.
module RepoParser
  def self.run
    repos = chain(Fetcher, Parser, Filterer, Sorter)
    Result.new(repos)
  end

  def self.chain(*processors)
    # the first is called with no args
    value = processors.shift.call

    processors.each do |proc|
      value = proc.call(value)
    end

    value
  end

  # Result stores the result of a parsing
  Result = Struct.new(:repositories) do
    def to_s
      lines = []

      lines << <<-STRING
        RepoParser
        ==========
      STRING

      lines += repositories.map(&:to_s)

      lines << <<-STRING
        Total: #{repositories.length}
      STRING

      lines.join
    end
  end

  API_URL = 'https://api.github.com/repositories'.freeze

  # Fetcher fetches an api response
  class Fetcher
    def self.call
      HTTParty.get(API_URL).parsed_response
    end
  end

  # Parser parses an api response into Repository objects
  class Parser
    def self.call(response)
      response.map do |json|
        Repository.new(json['name'],
                       json['html_url'],
                       json['owner']['login'],
                       json['fork'])
      end
    end
  end

  # Repository represents a repository
  Repository = Struct.new(:name, :url, :owner, :fork) do
    def to_s
      <<-STRING
        #{name}:
          name:  #{name}
          url:   #{url}
          owner: #{owner}
        ----------
      STRING
    end
  end

  # Filterer filters non-matching repositories
  class Filterer
    def self.call(repos)
      repos.select do |repo|
        allow?(repo)
      end
    end

    def self.allow?(repo)
      repo.name =~ /ruby/ &&
        !repo.fork
    end
  end

  # Sorter sorts repos by owner
  class Sorter
    def self.call(repos)
      repos.sort_by(&:owner)
    end
  end
end
