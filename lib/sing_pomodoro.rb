require 'rubygems'
require 'sinatra'
require 'active_record'
require 'haml'

require File.dirname(__FILE__) + '/../lib/pomodoro'
require File.dirname(__FILE__) + '/../lib/models'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + '/../views'

get '/' do
  @pomodoros = Pomodoro.all
  haml :index
end

get '/start/:for' do
  Pomodoro.start(params[:for].split)
end

get '/interrupt/:for' do
  Pomodoro.interrupt(params[:for].split)
end