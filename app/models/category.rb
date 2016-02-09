class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :post_categories
  has_many :posts, through: :post_categories

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.gsub(/\W/, '-').gsub(/-{2,}/, '-').downcase.strip
    self.slug = append_suffix(self.slug)
  end

  def append_suffix(str)
    counter = 2
    cat = Category.find_by(slug: str)
    while cat && cat != self
      # if last character is an integer remove it from the slug
      str = str.split("-").slice(0...-1).join("-") if str.split("-").last.to_i != 0
      str.concat("-#{counter}")
      cat = Category.find_by(slug: str)
      counter += 1
    end
    str
  end

  def to_param
    self.slug
  end

end
