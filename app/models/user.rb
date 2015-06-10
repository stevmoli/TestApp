class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  attr_accessor :password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :name
  validates_uniqueness_of :name

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def to_s
    name
  end

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def exists?(user)
    User.where(name: @user.name).present?
  end
end
