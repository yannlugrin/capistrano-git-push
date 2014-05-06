# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-git-push'
  spec.version       = `cat VERSION`
  spec.authors       = ['Yann Lugrin']
  spec.email         = ['yann.lugrin@liquid-concept.ch']
  spec.description   = %q{A capistrano git strategy to deploy local repository by git push}
  spec.summary       = %q{Capistrano git push strategy}
  spec.homepage      = 'https://github.com/yannlugrin/capistrano-git-push'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'mocha'

  spec.add_dependency 'capistrano', '~> 3.2'
end
