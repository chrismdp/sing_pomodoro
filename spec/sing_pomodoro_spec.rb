require File.dirname(__FILE__) + '/spec_helper'

describe 'Sing Pomodoro' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  before do
    Pomodoro.delete_all
  end

  it 'shows the count of existing pomodoros' do
    Pomodoro.start(:who => "chris@test.com")
    Pomodoro.start(:who => ["joe@test.com", "bob@test.com"])
    get '/'
    last_response.body.should match(/2 pomodoros running/)
  end

  it 'shows a list of existing pomodoros' do
    Pomodoro.start(:who => "chris@test.com")
    Pomodoro.start(:who => ["joe@test.com", "bob@test.com"])
    get '/'
    last_response.body.should match(/chris/)
    last_response.body.should match(/joe/)
    last_response.body.should match(/bob/)
  end
  
  it 'responds to starting a pomodoro from a user' do
    Pomodoro.should_receive(:start).with(:who => ['chris@edendevelopment.co.uk'])
    post '/start/chris@edendevelopment.co.uk'
  end
  
  it 'responds to starting a pomodoro from two users' do
    Pomodoro.should_receive(:start).with(:who => ['chris@edendevelopment.co.uk', 'john@test.com'])
    post '/start/chris@edendevelopment.co.uk+john@test.com'
  end
  
  it 'responds to interrupting a pomodoro' do
    Pomodoro.should_receive(:interrupt).with(:who => ['chris@edendevelopment.co.uk', 'john@test.com'])
    post '/interrupt/chris@edendevelopment.co.uk+john@test.com'
  end
end