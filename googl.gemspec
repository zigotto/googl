# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{googl}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["J\303\251sus Lopes"]
  s.date = %q{2011-01-11}
  s.description = %q{Small library for Google URL Shortener API}
  s.email = %q{jlopes@zigotto.com}
  s.files = ["lib/googl", "lib/googl/expand.rb", "lib/googl/request.rb", "lib/googl/shorten.rb", "lib/googl.rb", "Rakefile", "README.rdoc"]
  s.homepage = %q{http://zigotto.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Wrapper for Google URL Shortener API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.6.1"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end
