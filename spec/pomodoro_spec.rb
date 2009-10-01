require File.dirname(__FILE__) + '/spec_helper'

describe Pomodoro do
  before do
    Pomodoro.stub!(:create!) do |args|
      Pomodoro.new(args)
    end
  end

  context 'starting' do
    it 'ensures that you have someone starting the Pomodoro' do
      Pomodoro.start(:who => '').should raise_error
    end
  
    it 'records one person who has started the Pomodoro' do
      p = Pomodoro.start :who => 'chris@test.com'
      p.who.should == ['chris@test.com']
    end
  
    it 'records two people starting a Pomodoro' do
      p = Pomodoro.start :who => ['chris@test.com', 'joe@test.com']
      p.who.should == ['chris@test.com', 'joe@test.com']
    end  
  end

  context 'existing' do
    before do
      p = Pomodoro.start :who => "chris@test.com"
      Pomodoro.stub!(:find).and_return(p)
    end

    it 'retrieves existing pomodoros' do
      p = Pomodoro.existing("chris@test.com")
      p.should be_running
    end
  
    it 'records the interruption of an existing Pomodoro' do
      p = Pomodoro.existing("chris@test.com")
      p.interrupt!
      p.should have(1).interrupts
    end
  end
end