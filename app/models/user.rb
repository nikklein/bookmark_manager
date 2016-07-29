require 'bcrypt'
require 'dm-validations'
require 'securerandom'


class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, :required => true, unique: true

  property :password_digest, String, length: 60
  property :password_token, String, length: 60


  validates_confirmation_of :password
  validates_presence_of :password
  validates_format_of :email, :as => :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def generate_token
    self.password_token = SecureRandom.hex
    self.save
  end

  def self.authenticate(email, password)
  # that's the user who is trying to sign in
  user = first(email: email)
  # if this user exists and the password provided matches
  # the one we have password_digest for, everything's fine
  #
  # The Password.new returns an object that has a different implementation of the equality(`==`)
  # method. Instead of comparing two passwords directly
  # (which is impossible because we only have a one-way hash)
  # the == method calculates the candidate password_digest from
  # the password given and compares it to the password_digest
  # it was initialised with.
  # So, to recap: THIS IS NOT A STRING COMPARISON
    if user && BCrypt::Password.new(user.password_digest) == password
    # return this user
      user
    else
      nil
    end
  end


end
