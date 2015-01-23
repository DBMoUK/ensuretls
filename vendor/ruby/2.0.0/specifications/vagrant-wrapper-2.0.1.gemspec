# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "vagrant-wrapper"
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["BinaryBabel OSS"]
  s.date = "2014-12-16"
  s.description = "Since Vagrant 1.1+ is no longer distributed via Gems, vagrant-wrapper allows you to require and interact\nwith the newer package versions via your Gemfile, shell, or Ruby code. It allows the newer packaged\nversion to take precedence even if the older Vagrant gem remains installed.\nSee https://github.com/org-binbab/gem-vagrant-wrapper for more details.\n"
  s.email = ["projects@binarybabel.org"]
  s.executables = ["vagrant"]
  s.files = ["bin/vagrant"]
  s.homepage = "http://code.binbab.org"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Wrapper/binstub for os packaged version of Vagrant."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<vagrant>, ["= 1.0.7"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<vagrant>, ["= 1.0.7"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<vagrant>, ["= 1.0.7"])
  end
end
