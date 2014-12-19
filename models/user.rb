# encoding: utf-8
class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation

  validates_format_of :email, :with => /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, :unless => Proc.new { |t| t.hashed_password }
  validates_presence_of :password, :unless => Proc.new { |t| t.hashed_password }
  validates_confirmation_of :password

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def admin?
    self.permission_level == -1 || self.id == 1
  end

  def site_admin?
    self.id == 1
  end

  def to_ary
    self.attributes.values
  end
  
  

  def self.authenticate(email, pass)
    current_user = User.where(email: email).first
    return nil if current_user.nil?
    return current_user if User.encrypt(pass, current_user.salt) == current_user.hashed_password
    nil
  end

  def db_instance
    @instance
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  #def self.page_limit
  #  20
  #end

  #def self.page_offset(page = 0)
  #  page.to_i * self.page_limit
  #end
end

class Hash
  def stringify
    inject({}) do |options, (key, value)|
      options[key.to_s] = value.to_s
      options
    end
  end

  def stringify!
    each do |key, value|
      delete(key)
      store(key.to_s, value.to_s)
    end
  end
end  
