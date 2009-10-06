class Pomodoro < ActiveRecord::Base

  MINIMUM_SECS = 25 * 60
  MAXIMUM_SECS = 45 * 60

  named_scope :successful, { :conditions => "finished_at IS NOT NULL and (finished_at - started_at) >= #{MINIMUM_SECS}" }
  named_scope :incomplete, { :conditions => "finished_at IS NOT NULL and (finished_at - started_at) < #{MINIMUM_SECS}" }
  named_scope :running, { :conditions => ['finished_at IS NULL and (started_at >= ?)', Time.now.to_i - MAXIMUM_SECS] }

  def self.start(args = {})
    create!(:who => serialise_who(args[:who]), :started_at => Time.now)
  end

  def self.existing(who)
    running.find_by_who(serialise_who(who))
  end

  def people
    return @people unless @people.nil?
    @people = Pomodoro.deserialise_who(who).collect {|p| Person.new(p) }
  end

  def display_who
    people.map {|p| p.name }
  end
  
  def target
    started_at + MINIMUM_SECS
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