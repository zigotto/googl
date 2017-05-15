$:.push File.expand_path('../lib', __FILE__)
require 'googl/version'

Gem::Specification.new do |s|
  s.name = 'googl'
  s.version = Googl::VERSION
  s.authors = ['Jesus Lopes']
  s.homepage = 'http://github.com/zigotto/googl'
  s.email = 'jlopes@zigotto.com.br'
  s.licenses = ['MIT']
  s.summary = 'Wrapper for the Google URL Shortener API'
  s.description = 'Wrapper for the Google URL Shortener API'

  s.files = Dir['lib/**/*'] + %w(MIT-LICENSE Rakefile README.rdoc VERSION)
  s.test_files = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.add_dependency('httparty', '~> 0.10.0')
  s.add_dependency('json', '>= 1.4.6')
  s.add_development_dependency('rake', '~> 10')
  s.add_development_dependency('rspec', '~> 2.10.0')
  s.add_development_dependency('timecop', '~> 0.7.1')
  s.add_development_dependency('webmock', '~> 1.8.6')
end
