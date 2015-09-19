class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  after_create :auto_upvote

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  has_one :rating, as: :rateable

  default_scope { order('rank DESC')}
  scope :ordered_by_title, -> { order("title ASC")  }
  scope :ordered_by_reverse_created_at, -> { order("created_at DESC") }


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  def auto_upvote
    user.votes.create!(post: self, value: 1)
  end
end
