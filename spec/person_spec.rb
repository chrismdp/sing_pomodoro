require File.dirname(__FILE__) + '/spec_helper'

describe Person do
  context "name + email" do
    it 'will not display email addresses when asked for the name' do
      Person.new("Chris Parsons <fssdf@sfdk.com>").name.should == 'Chris Parsons'
    end
  
    it 'shows a gravatar url' do
      Person.new("Chris Parsons <fssdf@sfdk.com>").gravatar_url.should 
        match(/cc7e3663c6a3417f9e72f7fde3d8f2c0/)
    end
  end
  
  context 'email only' do
    it 'will show the gravatar correctly' do
      Person.new("fssdf@sfdk.com").gravatar_url.should match(/cc7e3663c6a3417f9e72f7fde3d8f2c0/)
    end

    it 'will show the name as Anonymous' do
      Person.new("fssdf@sfdk.com").name.should == 'fssdf'
    end
  end

  context 'name only' do
    it 'will show the correct name' do
      Person.new("Chris Parsons").name.should == 'Chris Parsons'
    end
    it 'will show the correct missing gravatar for a missing email address' do
      Person.new("Chris Parsons").gravatar_url.should match(/missing/)
    end
  end
  
  context 'malformed' do
    it 'will handle blank emails correctly' do
      Person.new("<>").name.should == 'Anonymous'
      Person.new("<>").gravatar_url.should match(/missing/)
    end
  end
end