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
      p.display_who.should == ['chris@test.com']
    end
  
    it 'records two people starting a Pomodoro' do
      p = Pomodoro.start :who => ['chris@test.com', 'joe@test.com']
      p.display_who.should == ['chris@test.com', 'joe@test.com']
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

    it 'will not display email addresses' do
      @p.display_who.should == ['Chris Parsons']
    end
  end
end