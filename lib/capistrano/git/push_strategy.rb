# Original code from capistrano git default strategy under MIT licence
# (Copyright (c) 2012-2013 Tom Clements, Lee Hambley)
#
# New code also under MIT licence
# (Copyright (c) 2014 Yann Lugrin

require 'capistrano/git'

class Capistrano::Git < Capistrano::SCM
  module PushStrategy
    def test
      test! " [ -f #{repo_path}/HEAD ] "
    end

    def check
      test! :git, :'ls-remote -h', repo_url
    end

    def clone
      git :clone, '--mirror', repo_url, repo_path
    end

    def update
      git :remote, :update
    end

    def release
      git :archive, fetch(:branch), '| tar -x -f - -C', release_path
    end

    def fetch_revision
      context.capture(:git, "rev-parse --short #{fetch(:branch)}")
    end
  end
end
