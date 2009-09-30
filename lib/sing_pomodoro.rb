require 'rubygems'
require 'sinatra'
require 'active_record'

require File.dirname(__FILE__) + '/../lib/pomodoro'
require File.dirname(__FILE__) + '/../lib/models'

get '/' do
  "Hello from Sing Pomodoro"
end

get '/start/:for' do
  Pomodoro.start(params[:for].split)
end

get '/interrupt/:for' do
  Pomodoro.interrupt(params[:for].split)
end