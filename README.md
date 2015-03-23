# RepoParser

A coding example.

## Task

Take response of https://api.github.com/repositories and perform the following actions;

* search results for any repository with “ruby” in the name and are not forks
* sort Alphabetically by owner name
* response should be displayed showing repo name, owner name, URL to repo

## Try it

    $ gem install repo_parser

    $ repo-parser

    RepoParser
    ==========
    ruby-on-rails-tmbundle:
      name:  ruby-on-rails-tmbundle
      url:   https://github.com/drnic/ruby-on-rails-tmbundle
      owner: drnic
    ----------
    ruby-git:
      name:  ruby-git
      url:   https://github.com/schacon/ruby-git
      owner: schacon
    ----------
    Total: 2
