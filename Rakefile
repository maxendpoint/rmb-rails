require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
  
    gem.description = <<-EOF
      ...something interesting here...
    EOF

    gem.name = "rmb-rails"
    gem.summary = %Q{RESTful Message Beans for Rails}
    gem.email = %Q{keburgett@gmail.com}
    gem.authors = ["Ken Burgett"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings

    gem.has_rdoc = true
    gem.homepage = %q{http://github.com/explainer/rmb-rails}
    gem.rdoc_options = ["--charset=UTF-8"]
    gem.require_paths = ["lib"]
    gem.rubyforge_project = %q{rmb-rails}
    gem.rubygems_version = %q{1.3.1}
  
    gem.add_dependency(%q<stomp>, [">= 1.1"])
    gem.add_dependency(%q<mechanize>, ["= 0.9.2"])
    gem.add_dependency(%q<daemons>, [">= 1.0.10"])
    
    gem.files = [
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
    
    gem.extra_rdoc_files = [
      "LICENSE",
      "README.rdoc"
    ]
  end

  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rmb-rails #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

