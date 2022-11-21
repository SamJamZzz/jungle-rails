class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, length: {minimum: 2}
  before_save { email.downcase! }

  def self.authenticate_with_credentials(email, password)
    email = email.strip
    email = email.downcase
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
