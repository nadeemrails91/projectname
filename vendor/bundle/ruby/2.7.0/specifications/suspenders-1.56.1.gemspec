# -*- encoding: utf-8 -*-
# stub: suspenders 1.56.1 ruby lib

Gem::Specification.new do |s|
  s.name = "suspenders".freeze
  s.version = "1.56.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 2.7.4".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["thoughtbot".freeze]
  s.date = "2022-07-17"
  s.description = "Suspenders is a base Rails project that you can upgrade. It is used by\nthoughtbot to get a jump start on a working app. Use Suspenders if you're in a\nrush to build something amazing; don't use it if you like missing deadlines.\n".freeze
  s.email = "support@thoughtbot.com".freeze
  s.executables = ["suspenders".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze, "bin/suspenders".freeze]
  s.homepage = "http://github.com/thoughtbot/suspenders".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.4".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Generate a Rails app using thoughtbot's best practices.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bitters>.freeze, [">= 2.0.4"])
    s.add_runtime_dependency(%q<parser>.freeze, [">= 3.0"])
    s.add_runtime_dependency(%q<bundler>.freeze, [">= 2.1"])
    s.add_runtime_dependency(%q<rails>.freeze, ["~> 6.0.0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.2"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bitters>.freeze, [">= 2.0.4"])
    s.add_dependency(%q<parser>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 2.1"])
    s.add_dependency(%q<rails>.freeze, ["~> 6.0.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.2"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
  end
end
