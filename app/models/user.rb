require 'digest/sha1'

class User < ActiveRecord::Base
  make_flagger
  attr_accessor :password, :photo
  
  before_save :encrypt_password
  after_save :clear_password
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, :presence => true, :uniqueness => true, :length => {:in => 3..30}
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password,:presence => true, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create
  
  attr_accessible :username, :email, :password, :password_confirmation, :photo
  has_many :posts, dependent: :destroy
  
  def self.authenticate(username_or_email = "",login_password = "")
    if EMAIL_REGEX.match(username_or_email)    
      user=User.find_by_email(username_or_email)
    else
      user=User.find_by_username(username_or_email)
    end

  return false unless user.present?
    
   user.password = login_password  
    if user && user.password == login_password && user.encrypt_password == user.match_password
      return user
    else
      return false
    end
  end   
  
  def match_password
    checker
  end
  
  def encrypt_password
    if self.password.present? 
     self.encrypted_password = checker
    end
  end
  
  def checker
    self.salt = Digest::SHA1.hexdigest("#{email}#{DateTime.now}") unless self.salt.present?
    Digest::SHA1.hexdigest(self.password,self.salt)
  end
  
  def clear_password
    self.password = nil
    self.salt = nil
  end
end