require 'resume/version'

# Resume is a coding test
# involving scraping some github json,
# and sorting it.
module Resume
  def self.run
    [Repo.new('rails', 'https://github.com/rails/rails', 'dhh')]
  end

  Repo = Struct.new(:repo_name, :repo_url, :owner_name)
end
