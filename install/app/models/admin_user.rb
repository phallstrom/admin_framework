require 'digest/sha1'

class AdminUser < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  serialize :permissions

  validates_presence_of :login
  validates_uniqueness_of :login
  validates_length_of :login, :within => 2..12
  validates_format_of :login, :with => /\A[A-Za-z0-9]*\Z/i

  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?, :on => :create
  validates_length_of       :password, :within => 6..20, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?

  validates_presence_of :name
  validates_presence_of :email

  SECRET_SALT = 'sam-and-tom' unless const_defined? "SECRET_SALT"

  PERMISSIONS = {
    :admin_users => 'Admin Users'
  } unless const_defined? "PERMISSIONS"

  #
  #
  #
  def before_save
    unless password.blank? then
      self.password_hash = self.class.hash_a_password(password)
    end

    self.email = self.email.strip.downcase unless self.email.blank?
  end
  
  #
  # Hash a string into a valid password hash
  #
  def self.hash_a_password(str)
    Digest::SHA1.hexdigest("#{SECRET_SALT}-#{str}")
  end

  #
  #
  #
  def self.make_token(login, request)
    Digest::SHA1.hexdigest(request.env['REMOTE_ADDR'].split('.')[0..1].join('.') + request.env['HTTP_USER_AGENT'].to_s + login + SECRET_SALT)
  end

  #
  #
  #
  def password_required?
    password_hash.blank? || !password.blank? || !password_confirmation.blank?
  end
  private :password_required?

end
