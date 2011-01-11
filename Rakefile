require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts = %w(-fp --color)
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'googl'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s|
  s.name        = "googl"
  s.version     = "0.0.1"
  s.summary     = "Wrapper for Google URL Shortener API"
  s.description = "Small library for Google URL Shortener API"
  s.files       = FileList['lib/**/*', '[A-Z]*'].to_a
  s.author      = "Jésus Lopes"
  s.email       = "jlopes@zigotto.com"
  s.homepage    = "http://zigotto.com"
  s.add_dependency('httparty', '>= 0.6.1')
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "fakeweb"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem #{spec.name}-#{spec.version}.gem"
task :install do
  system("gem install pkg/#{spec.name}-#{spec.version}.gem --no-ri --no-rdoc")
end

desc "Create a gemspec file"
task :make_spec do
  File.open("#{spec.name}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
