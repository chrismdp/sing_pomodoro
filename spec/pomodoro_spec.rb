require File.dirname(__FILE__) + '/spec_helper'

describe Pomodoro do
  before do
    stub_pomodoros!
  end

  context 'starting' do
    it 'ensures that you have someone starting the Pomodoro' do
      Pomodoro.start(:who => '').should raise_error
    end
  
    it 'records one person who has started the Pomodoro' do
      p = Pomodoro.start :who => 'chris@test.com'
      p.display_who.should == ['chris']
    end
  
    it 'records two people starting a Pomodoro' do
      p = Pomodoro.start :who => ['chris@test.com', 'joe@test.com']
      p.display_who.should == ['chris', 'joe']
    end  
  end

  context 'existing' do
    before do
      @p = Pomodoro.start :who => "Chris Parsons <chris@test.com>"
    end

    it 'retrieves existing pomodoros' do
      @p.should be_running
    end
  
    it 'records the interruption of an existing Pomodoro' do
      @p.interrupt!
      @p.should have(1).interrupts
    end

    it 'finishes the existing pomodoro' do
      @p.finish!
      @p.should be_finished
    end

    it "gives me an array of people when I ask" do
      @p.should have(1).people
    end
    
    it 'shows me the target finish time' do
      @p.target.should == @p.started_at + 1500
    end
  end
end