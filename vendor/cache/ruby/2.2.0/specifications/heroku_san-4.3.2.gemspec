# -*- encoding: utf-8 -*-
# stub: heroku_san 4.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "heroku_san"
  s.version = "4.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Elijah Miller", "Glenn Roberts", "Ryan Ahearn", "Ken Mayer"]
  s.date = "2013-10-28"
  s.description = "Manage multiple Heroku instances/apps for a single Rails app using Rake"
  s.email = "elijah.miller@gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/fastestforward/heroku_san"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A bunch of useful Rake tasks for managing your Heroku apps. NOTE: The Heroku Toolbelt must be installed to use this gem. https://toolbelt.heroku.com/"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<heroku-api>, [">= 0.1.2"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<heroku-api>, [">= 0.1.2"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<heroku-api>, [">= 0.1.2"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
