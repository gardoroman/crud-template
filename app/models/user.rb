require 'bcrypt'

class User < ActiveRecord::Base

  #ADD ASSOCIATIONS

  # Bcrypt module is used to encrypt the user's password
  # the password_hash variable will be stored as a string
  include BCrypt

  validates :username,  presence: true,
                        uniqueness: {  message: "The username provided already exists." }

  validates :email,     presence: true,
                        uniqueness:  {  message: "The email provided already exists." },
                        format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Invalid email format" }

  validate :validate_password

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @raw_password = new_password
    self.password_hash = Password.create(new_password)
  end

  def authenticate(auth_password)
    self.password == auth_password
  end

  private
  def validate_password
    if @raw_password.length == 0
      errors.add(:password, "is required")
    elsif @raw_password.length < 6
      errors.add(:password, "must be longer than 6 characters")
    end
  end
end
