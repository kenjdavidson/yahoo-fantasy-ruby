# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yahoo_fantasy/version'

Gem::Specification.new do |spec|
  spec.name          = 'yahoo-fantasy'
  spec.version       = YahooFantasy::VERSION
  spec.authors       = ['Ken Davidson']
  spec.email         = ['ken.j.davidson@live.ca']

  spec.summary       = 'Provide access to Yahoo Fantasy API v2'
  spec.description   = 'Perform standard or custom functionality using the Yahoo Fantasy API.'
  spec.homepage      = 'https://www.github.com/kenjdavidson/yahoo-fantasy-ruby'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
    'allowed_push_host' => 'true',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => spec.homepage
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(\.|test|example|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'nokogiri', '~>1.12'
  spec.add_dependency 'oauth2', '~>1.2'
  spec.add_dependency 'omniauth-oauth2', '~> 1.7'
  spec.add_dependency 'representable', '~>3.1'

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~>1.22'
  spec.add_development_dependency 'solargraph', '~>0.44'
  spec.add_development_dependency 'yard-struct', '~> 1.1'
end
