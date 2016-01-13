class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  validates :url, presence: true

  def self.search(search)
    where("title LIKE ?", "%#{search}")
    where("description LIKE ?", "%#{search}")
  end
end
