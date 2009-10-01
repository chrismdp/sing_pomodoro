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

post '/start/:for' do
  Pomodoro.start(:who => params[:for].split)
  "OK"
end

post '/interrupt/:for' do
  Pomodoro.interrupt(:who => params[:for].split)
  "OK"
end