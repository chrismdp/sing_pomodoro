require File.dirname(__FILE__) + '/../lib/sing_pomodoro'

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'

ActiveRecord::Base.establish_connection(use_database('production'))

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
