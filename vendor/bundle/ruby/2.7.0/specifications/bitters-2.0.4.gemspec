# -*- encoding: utf-8 -*-
# stub: bitters 2.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "bitters".freeze
  s.version = "2.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kyle Fiedler".freeze, "Reda Lemeden".freeze, "Tyson Gach".freeze, "Will McMahan".freeze]
  s.date = "2020-04-24"
  s.description = "    Bitters helps designers start projects faster by defining a basic set of\n    Sass variables, default element style and project structure. It's been\n    specifically designed for use within web applications. Bitters should live\n    in your project's root Sass directory and we encourage you to modify and\n    extend it to meet your design and brand requirements.\n".freeze
  s.email = "design+bitters@thoughtbot.com".freeze
  s.executables = ["bitters".freeze]
  s.files = ["bin/bitters".freeze]
  s.homepage = "https://github.com/thoughtbot/bitters".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Scaffold styles, variables and structure for Bourbon projects.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<sass>.freeze, ["~> 3.4"])
    s.add_runtime_dependency(%q<thor>.freeze, ["~> 1.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<sass>.freeze, ["~> 3.4"])
    s.add_dependency(%q<thor>.freeze, ["~> 1.0"])
  end
end
