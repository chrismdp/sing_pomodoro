begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end
begin
  require 'spec/rake/spectask'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

require File.dirname(__FILE__) + '/lib/sing_pomodoro'

task :default => :spec

desc "Run the specs under spec/models"
Spec::Rake::SpecTask.new do |t|
  @appenv = 'test'
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/*_spec.rb']
end

namespace :db do
  desc "Migrate the database"
    task :migrate do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end