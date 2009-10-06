require 'md5'

class Person
  attr_reader :name

  EMAIL_REGEX = '(([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))'
  
  def initialize(namestring)
    if namestring.include? '<'
      @name, @email, email_prefix = namestring.scan(/([^<]*)<#{EMAIL_REGEX}>/i)[0]
      @name ||= (email_prefix || "Anonymous")
      @name.strip!
    elsif namestring.include? '@'
      @email, email_prefix = namestring.scan(/#{EMAIL_REGEX}/i)[0]
      @name = email_prefix
    else
      @name = namestring
      @email = nil
    end
  end
  
  def gravatar_url
    if @email.nil?
      "http://www.gravatar.com/avatar/missing.jpg?s=50"
    else
      "http://www.gravatar.com/avatar/#{MD5::md5(@email.downcase)}.jpg?s=50"
    end
  end
end