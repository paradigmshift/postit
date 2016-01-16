class Comment < ActiveRecord::Base
  belongs_to :posts
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  validates :body, presence: true, length: {minimum: 10}
  has_many :votes, as: :voteable

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end
