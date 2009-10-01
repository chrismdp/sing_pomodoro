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
  
  def after_find
    int = self['interrupts'] || ""
    @interrupts = int.split(',')
  end
  
  def interrupts
    @interrupts
  end
  
  def after_save
    @interrupts ||= []
    self[:interrupts] = @interrupts.join(',')
  end
  
  def interrupt!
    @interrupts ||= []
    @interrupts << Time.now
    save
  end
end