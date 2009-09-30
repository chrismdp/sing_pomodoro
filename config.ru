require File.dirname(__FILE__) + '/lib/sing_pomodoro'
ActiveRecord::Base.establish_connection(use_database('development'))
run Sinatra::Application

