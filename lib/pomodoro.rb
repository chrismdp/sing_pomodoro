class Pomodoro < ActiveRecord::Base

  MINIMUM_SECS = 25 * 60

  named_scope :successful, { :conditions => ['finished_at <> ? and (finished_at - started_at) >= ?', nil, MINIMUM_SECS] }
  named_scope :incomplete, { :conditions => ['finished_at <> ? and (finished_at - started_at) < ?', nil, MINIMUM_SECS] }
  named_scope :running, { :conditions => ['finished_at = ?', nil] }

  def self.start(args = {})
    create!(:who => serialise_who(args[:who]), :started_at => Time.now)
  end

  def self.existing(who)
    find_by_who(serialise_who(who))
  end

  def display_who
    Pomodoro.deserialise_who(who).map do |p|
      p.gsub /\s?<[^>]+>/, ''
    end
  end
  
  def running?
    !finished?
  end
  
  def after_find
    int = self['interrupts'] || ""
    @interrupts = int.split(',')
  end
  
  def before_save
    @interrupts ||= []
    self[:interrupts] = @interrupts.join(',')
  end

  def interrupts
    @interrupts
  end
  
  def interrupt!
    @interrupts ||= []
    @interrupts << Time.now
    save
  end
  
  def finish!
    self.finished_at = Time.now
    save
  end
  
  def finished?
    !self.finished_at.nil?
  end
  
private
  def self.serialise_who(w)
    w.to_a.join(',')
  end
  
  def self.deserialise_who(w)
    w.split(',')
  end
end