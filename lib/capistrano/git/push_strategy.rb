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
      run_locally do
        test 'git show-ref'
      end
    end

    def clone
      git :init, '--bare', repo_path
    end

    def update
      host = context.host

      run_locally do
        execute :git, :push, '--force', "#{host.user}@#{host.hostname}:#{repo_path} #{fetch(:branch)}:master"
      end
    end

    def release
      git :archive, 'master', '| tar -x -f - -C', release_path
    end

    def fetch_revision
      context.capture(:git, 'rev-parse --short master')
    end
  end
end
