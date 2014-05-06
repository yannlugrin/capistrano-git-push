require 'spec_helper'

require 'capistrano/git/push_strategy'

module Capistrano
  describe Git::PushStrategy do
    let(:context) { Class.new.new }
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
        context.expects(:repo_url).returns(:url)
        context.expects(:test).with(:git, :'ls-remote -h', :url).returns(true)

        subject.check
      end
    end

    describe '#clone' do
      it 'should run git clone' do
        context.expects(:repo_url).returns(:url)
        context.expects(:repo_path).returns(:path)

        context.expects(:execute).with(:git, :clone, '--mirror', :url, :path)

        subject.clone
      end
    end

    describe '#update' do
      it 'should run git update' do
        context.expects(:execute).with(:git, :remote, :update)

        subject.update
      end
    end

    describe '#release' do
      it 'should run git archive' do
        context.expects(:fetch).returns(:branch)
        context.expects(:release_path).returns(:path)

        context.expects(:execute).with(:git, :archive, :branch, '| tar -x -f - -C', :path)

        subject.release
      end
    end

    describe '#fetch_revision' do
      it 'should run git rev-parse' do
        context.expects(:fetch).returns(:branch)
        context.expects(:capture).with(:git, 'rev-parse --short branch')

        subject.fetch_revision
      end
    end
  end
end
