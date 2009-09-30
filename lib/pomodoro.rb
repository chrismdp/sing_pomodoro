class Pomodoro < ActiveRecord::Base
  def self.start(args = {})
    create!(:who => args[:who].to_a.join(' '))
  end

  def self.existing(who)
    find_by_who(who.to_a.join(' '))
  end
  
  def who
    self['who'].split
  end
  
  def running?
    !@failed
  end

  def interrupt!
    @failed = true
    save
  end
end