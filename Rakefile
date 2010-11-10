require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "swagger"
    gem.summary = %Q{Everything Resque provides minus Redis}
    gem.description = %Q{Duck punch Resque to use active record for backround jobs instead of redis}
    gem.email = "mdeiters@gmail.com"
    gem.homepage = "http://github.com/mdeiters/swagger"
    gem.authors = ["mdeiters"]
    gem.add_development_dependency "rspec", "> 2"
    gem.add_development_dependency "sqlite3-ruby"
    gem.add_development_dependency "activerecord"
    gem.add_dependency "resque"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = "--color"
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rspec_opts = "--color"
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  require File.expand_path("lib/swagger/version")

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "swagger #{Swagger.version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace "resque" do
  resque_dir = "resque"

  file resque_dir do
    raise "No local resque found. Either 'git clone' it here or symlink a local copy."
    #puts "No local resque found, fetching latest from github."

    # https://github.com/pivotal/erector/blob/master/Rakefile#L142
    #oldenv = ENV.dup
    #ENV.delete_if {|k,v| k =~ /^GIT_/ }
    #sh "git clone git://github.com/defunkt/resque.git #{resque_dir}"
    #ENV = oldenv
  end

  require 'rake/testtask'
  
  Dir[ File.expand_path("lib/swagger/impersonators/*.rb") ].each do |impersonator|
    name = File.basename(impersonator, ".rb")

    # HAX: Maybe just shell out and use resque's rake file?
    Rake::TestTask.new name do |test|
      test.libs << "#{resque_dir}/test" << "#{resque_dir}/lib" << "lib" << "spec"
      test.ruby_opts = ["-rubygems -r swagger -r #{name}_spec_helper" ]
      test.test_files = FileList["#{resque_dir}/test/**/*_test.rb"]
    end

    task name => resque_dir
  end
end
