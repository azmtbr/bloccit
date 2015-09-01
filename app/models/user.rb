class User < ActiveRecord::Base
  has_many :posts

  before_save  :downcase_email
  before_save  :capitalize_name
  before_save  :enum_role

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

  enum role: [:member, :admin]

  def downcase_email
    self.email = email.downcase
  end

  def capitalize_name
    self.name = (self.name.split.each { |s| s.capitalize! }).join(" ")
  end

  def enum_role
    self.role ||= :member
  end
end
