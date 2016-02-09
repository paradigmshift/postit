class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug

  validates :title, presence: true
  validates :url, presence: true

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.title.gsub(/\W/, '-').gsub(/-{2,}/, '-').downcase.strip
    self.slug = append_suffix(self.slug)
  end

  def append_suffix(str)
    counter = 2
    post = Post.find_by(slug: str)
    while post && post != self
      # if last character is an integer remove it from the slug
      str = str.split("-").slice(0...-1).join("-") if str.split("-").last.to_i != 0
      str.concat("-#{counter}")
      post = Post.find_by(slug: str)
      counter += 1
    end
    str
  end

  def to_param
    self.slug
  end

end
