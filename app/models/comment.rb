class Comment < ActiveRecord::Base
  belongs_to :posts
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  validates :body, presence: true, length: {minimum: 10}
end
