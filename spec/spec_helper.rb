require File.dirname(__FILE__) + '/../lib/sing_pomodoro'

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'

require 'rspec_hpricot_matchers'
Spec::Runner.configure do |config|
 config.include(RspecHpricotMatchers)
end

def stub_pomodoros!
  Pomodoro.stub!(:create!) do |args|
    p = Pomodoro.new(args)
    p.stub!(:save).and_return(true)
    p
  end
end

ActiveRecord::Base.establish_connection(use_database('production'))

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
