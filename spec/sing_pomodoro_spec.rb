require File.dirname(__FILE__) + '/spec_helper'

describe 'Sing Pomodoro' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it 'shows /' do
    get '/'
    last_response.should be_ok
  end
  
  it 'responds to starting a pomodoro from a user' do
    Pomodoro.should_receive(:start).with(['chris@edendevelopment.co.uk'])
    get '/start/chris@edendevelopment.co.uk'
  end
  
  it 'responds to starting a pomodoro from two users' do
    Pomodoro.should_receive(:start).with(['chris@edendevelopment.co.uk', 'john@test.com'])
    get '/start/chris@edendevelopment.co.uk+john@test.com'
  end
  
  it 'responds to interrupting a pomodoro' do
    Pomodoro.should_receive(:interrupt).with(['chris@edendevelopment.co.uk', 'john@test.com'])
    get '/interrupt/chris@edendevelopment.co.uk+john@test.com'
  end
end