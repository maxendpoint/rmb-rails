# -*- encoding: utf-8 -*-
# This is a test KEB
Gem::Specification.new do |s|
  s.name = %q{rmb-rails}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ken Burgett"]
  s.date = %q{2009-07-23}
  s.description = %q{...something interesting here...}
  s.email = %q{keburgett@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "lib/listener_client.rb",
     "lib/listener_daemon.rb",
     "lib/listener_daemon_control.rb",
     "lib/listener_main.rb",
     "lib/mechanize_submitter.rb",
     "lib/rmb-rails.rb",
     "lib/stomp_subscriber.rb",
     "lib/submitter.rb",
     "lib/subscriber.rb",
     "rmb-rails.gemspec",
     "test/rmb-rails_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/explainer/rmb-rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rmb-rails}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{RESTful Message Beans for Rails}
  s.test_files = [
    "test/test_helper.rb",
     "test/rmb-rails_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<stomp>, [">= 1.1"])
      s.add_runtime_dependency(%q<mechanize>, ["= 0.9.2"])
      s.add_runtime_dependency(%q<daemons>, [">= 1.0.10"])
    else
      s.add_dependency(%q<stomp>, [">= 1.1"])
      s.add_dependency(%q<mechanize>, ["= 0.9.2"])
      s.add_dependency(%q<daemons>, [">= 1.0.10"])
    end
  else
    s.add_dependency(%q<stomp>, [">= 1.1"])
    s.add_dependency(%q<mechanize>, ["= 0.9.2"])
    s.add_dependency(%q<daemons>, [">= 1.0.10"])
  end
end
