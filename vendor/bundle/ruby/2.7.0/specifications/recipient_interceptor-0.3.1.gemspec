# -*- encoding: utf-8 -*-
# stub: recipient_interceptor 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "recipient_interceptor".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dan Croak".freeze]
  s.date = "2021-10-23"
  s.description = "    Avoid emailing your users from non-production environments.\n".freeze
  s.email = "dan@statusok.com".freeze
  s.homepage = "http://github.com/croaky/recipient_interceptor".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Intercept recipients when delivering email with the Mail gem.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<mail>.freeze, [">= 0"])
  else
    s.add_dependency(%q<mail>.freeze, [">= 0"])
  end
end
