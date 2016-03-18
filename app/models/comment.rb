class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  validates :body, presence: true, length: {minimum: 10}
  has_many :votes, as: :voteable

end
