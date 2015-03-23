require 'resume/version'
require 'httparty'

# Resume is a coding test
# involving scraping some github json,
# and sorting it.
module Resume
  def self.run
    fetched = Fetcher.new.repositories
    Repository.from_response(fetched)
  end

  class Fetcher
    include HTTParty
    base_uri "https://api.github.com"

    format :json

    def repositories
      self.class.get("/repositories").parsed_response
    end
  end

  class Repository < Struct.new(:name, :url, :owner, :fork)
    def self.from_response(response)
      response.map do |json|
        new(json["name"], json["html_url"], json["owner"]["login"], json["fork"])
      end
    end
  end

end
