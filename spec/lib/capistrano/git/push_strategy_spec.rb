require 'spec_helper'

require 'capistrano/git'
require 'capistrano/git/push_strategy'

module Capistrano
  describe Git::PushStrategy do
    let(:context) { Class.new.new }
    let(:run_locally) { SSHKit::Backend::Local.any_instance }
    let(:host) { mock(user: :user, hostname: :hostname)}
    subject { Capistrano::Git.new(context, Capistrano::Git::PushStrategy) }

    describe '#test' do
      it 'should call test for repo HEAD' do
        context.expects(:repo_path).returns('/path/to/repo')
        context.expects(:test).with ' [ -f /path/to/repo/HEAD ] '

        subject.test
      end
    end

    describe '#check' do
      it 'should test the repo url' do
        run_locally.expects(:test).with('git show-ref')

        subject.check
      end
    end

    describe '#clone' do
      it 'should run git clone' do
        context.expects(:repo_path).returns('/path/to/repo')

        context.expects(:execute).with(:git, :init, '--bare', '/path/to/repo')

        subject.clone
      end
    end

    describe '#update' do
      it 'should run git update' do
        context.expects(:host).returns(host)

        run_locally.expects(:repo_path).returns('/path/to/repo')
        run_locally.expects(:fetch).returns(:branch)

        run_locally.expects(:execute).with(:git, :push, '--force', 'user@hostname:/path/to/repo branch:master')

        subject.update
      end
    end

    describe '#release' do
      it 'should run git archive' do
        context.expects(:release_path).returns(:path)

        context.expects(:execute).with(:git, :archive, 'master', '| tar -x -f - -C', :path)

        subject.release
      end
    end

    describe '#fetch_revision' do
      it 'should run git rev-parse' do
        context.expects(:capture).with(:git, 'rev-parse --short master')

        subject.fetch_revision
      end
    end
  end
end
