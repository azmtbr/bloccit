class Rating < ActiveRecord::Base
  enum severity: [ :G, :PG, :PG13, :R ]

  has_many :topics
  has_many :posts
  has_many :ratings
  belongs_to :rateable, polymorphic: true

  def self.update_rating(rating_string)
    if rating_string != nil
      Rating.find_or_create_by(severity: rating_string.to_sym)
    end
  end
end
