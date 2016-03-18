module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :gen_slug
    class_attribute :slug_column
  end

  def gen_slug
    self.slug = self.send(self.class.slug_column).gsub(/\W/, '-').gsub(/-{2,}/, '-').downcase.strip
    self.slug = append_suffix(self.slug)
  end

  def append_suffix(str)
    counter = 2
    obj = self.class.find_by(slug: str)
    while obj && obj != self
      # if last character is an integer remove it from the slug
      str = str.split("-").slice(0...-1).join("-") if str.split("-").last.to_i != 0
      str.concat("-#{counter}")
      obj = self.class.find_by(slug: str)
      counter += 1
    end
    str
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end
