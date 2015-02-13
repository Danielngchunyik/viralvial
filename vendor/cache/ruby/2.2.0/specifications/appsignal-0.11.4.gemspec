# -*- encoding: utf-8 -*-
# stub: appsignal 0.11.4 ruby lib

Gem::Specification.new do |s|
  s.name = "appsignal"
  s.version = "0.11.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Robert Beekman", "Steven Weller", "Thijs Cadier", "Ron Cadier", "Jacob Vosmaer"]
  s.date = "2015-02-05"
  s.description = "The official appsignal.com gem"
  s.email = ["support@appsignal.com"]
  s.executables = ["appsignal"]
  s.files = ["bin/appsignal"]
  s.homepage = "https://github.com/appsignal/appsignal"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubygems_version = "2.4.5"
  s.summary = "Logs performance and exception data from your app to appsignal.com"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<thread_safe>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<thread_safe>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<thread_safe>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14.1"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end
