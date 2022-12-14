# -*- encoding: utf-8 -*-
# stub: title 0.0.8 ruby lib app

Gem::Specification.new do |s|
  s.name = "title".freeze
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "app".freeze]
  s.authors = ["Caleb Thompson".freeze]
  s.date = "2020-08-20"
  s.description = "Abuses I18n to set HTML <title>s".freeze
  s.email = ["caleb@calebthompson.io".freeze]
  s.homepage = "https://github.com/calebthompson/title".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "I18n your <title>s".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_runtime_dependency(%q<i18n>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_dependency(%q<i18n>.freeze, [">= 0"])
  end
end
