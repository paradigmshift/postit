class Category < ActiveRecord::Base
  include Sluggable

  validates :name, presence: true
  has_many :post_categories
  has_many :posts, through: :post_categories

  sluggable_column :name
end
