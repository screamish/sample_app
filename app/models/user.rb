# == Schema Information
# Schema version: 20100711072824
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of   :name, :email
  validates_length_of     :name, :maximum => 50
  validates_format_of     :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  # Automatically create the virtual attribute 'password_confirmation'
  validates_confirmation_of :password
  
  # Password validations
  validates_presence_of   :password
  validates_length_of     :password, :within => 6..40
  
  before_save   :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
  end
  
  private
  
    def encrypt_password
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      string
    end
  
end
