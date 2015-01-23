# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hocon"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Price", "Wayne Warren", "Dai Akatsuka", "Preben Ingvaldsen"]
  s.date = "2014-10-14"
  s.description = "== A port of the Java {Typesafe Config}[https://github.com/typesafehub/config] library to Ruby"
  s.email = "chris@puppetlabs.com"
  s.homepage = "https://github.com/cprice404/ruby-hocon"
  s.licenses = ["Apache License, v2"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "HOCON Config Library"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
  end
end
