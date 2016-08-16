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

  validate :password_has_valid_length

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def authenticate(auth_password)
    @plaintext = auth_password
    self.password == auth_password
  end

  def password_has_valid_length
   @plaintext && @plaintext.length > 6
  end
end
