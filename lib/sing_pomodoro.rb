require 'rubygems'
require 'sinatra'
require 'active_record'
require 'haml'
require 'sass'

require File.dirname(__FILE__) + '/../lib/pomodoro'
require File.dirname(__FILE__) + '/../lib/models'
require File.dirname(__FILE__) + '/../lib/person'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + '/../views'
set :public, File.dirname(__FILE__) + '/../public'

get '/' do
  @successful_pomodoros = Pomodoro.successful
  @running_pomodoros = Pomodoro.running
  @incomplete_pomodoros = Pomodoro.incomplete
  haml :index
end

def parse_who(params)
  params[:for].split(',')
end

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

post '/start/:for' do
  Pomodoro.start(:who => parse_who(params))
  "OK"
end

def do_for_existing(action, params)
  p = Pomodoro.existing(parse_who(params))
  if (p)
    if p.send(action)
      "OK"
    else
      "ERROR DOING #{action}"
    end
  else
    "NOT FOUND"
  end
end  

post '/interrupt/:for' do
  do_for_existing(:interrupt!, params)
end

post '/finish/:for' do
  do_for_existing(:finish!, params)
end