require 'resume/version'
require 'httparty'

# Resume is a coding test
# involving scraping some github json,
# and sorting it.
module Resume
  def self.run
    repos = Parser.call(Fetcher.call)
    Sorter.call(Filterer.call(repos))
  end

  # Fetcher fetches an api response
  class Fetcher
    def self.call
      HTTParty.get('https://api.github.com/repositories').parsed_response
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
  Repository = Struct.new(:name, :url, :owner, :fork)

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
