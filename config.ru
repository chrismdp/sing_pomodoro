require File.dirname(__FILE__) + '/lib/sing_pomodoro'
ActiveRecord::Base.establish_connection(use_database('production'))
run Sinatra::Application

