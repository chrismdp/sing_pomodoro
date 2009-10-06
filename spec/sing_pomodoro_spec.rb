require File.dirname(__FILE__) + '/spec_helper'

describe 'Sing Pomodoro' do
  include Rack::Test::Methods

  before do
    stub_pomodoros!
    @running = [Pomodoro.start(:who => "chris@test.com"),
    Pomodoro.start(:who => ["Joe <joe@test.com>", "Bob <bob@test.com>"])]
    Pomodoro.stub!(:running).and_return(@running)
    @successful = [Pomodoro.start(:who => 'charles@test')]
    Pomodoro.stub!(:successful).and_return(@successful)
    @incomplete = [Pomodoro.start(:who => 'gerald@test')]
    Pomodoro.stub!(:incomplete).and_return(@incomplete)
    Pomodoro.stub!(:count).and_return(2)
  end

  def app
    @app ||= Sinatra::Application
  end

  it 'shows a list of existing pomodoros' do
    Pomodoro.should_receive(:running).and_return(@running)
    get '/'
    last_response.body.should have_tag('div.running') do |inner|
      inner.to_s.should match /chris/
    end
  end
  
  it 'responds to starting a pomodoro from a user' do
    Pomodoro.should_receive(:start).with(:who => ['chris@edendevelopment.co.uk'])
    post '/start/chris@edendevelopment.co.uk'
  end
  
  it 'responds to starting a pomodoro from two users' do
    Pomodoro.should_receive(:start).with(:who => ['chris@edendevelopment.co.uk', 'john@test.com'])
    post '/start/chris@edendevelopment.co.uk,john@test.com'
    last_response.body.should match /OK/
  end
  
  it 'responds to interrupting a pomodoro' do
    Pomodoro.should_receive(:existing).with(['chris@edendevelopment.co.uk', 'john@test.com']).and_return(mock(:pom, :interrupt! => true))
    post '/interrupt/chris@edendevelopment.co.uk,john@test.com'
    last_response.body.should match /OK/
  end
  
  it 'responds to finishing a pomodoro' do
    Pomodoro.should_receive(:existing).with(['chris@edendevelopment.co.uk', 'john@test.com']).and_return(mock(:pom, :finish! => true))
    post '/finish/chris@edendevelopment.co.uk,john@test.com'
    last_response.body.should match /OK/
  end
end