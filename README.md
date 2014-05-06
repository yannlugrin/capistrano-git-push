# Capistrano::Git::Push

A capistrano git strategy to deploy local repository by git push.

## Usage

Add this line to your application's Gemfile:

    gem 'capistrano-git-push'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-git-push

and then add to `Capfile`:

    require 'capistrano/git/push_strategy'

and then add to `deploy.rb`:

    set :git_strategy, Capistrano::Git::PushStrategy


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
