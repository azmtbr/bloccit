class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts

  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :privately_viewable, -> (user) { user ? where(public: false) : nil }
  scope :publicly_viewable, -> { where(public: true) }

  has_one :rating, as: :rateable

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15}, presence: true
end
