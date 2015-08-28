class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  
  before_save { self.name = (name.split.each { |s| s.capitalize! }).join(" ") }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NAME_REGEX = /\A[A-Z][a-z]*\b/

  validates :name,
            length: { minimum: 1, maximum: 100 },
            presence: true,
            format: { with: NAME_REGEX}

  validates :password, presence: true, length: { minimum: 6 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 100 },
            format: { with: EMAIL_REGEX }

  has_secure_password
end
