class PopulateSlugColOfPosts < ActiveRecord::Migration
  def change
    Post.all.each { |post| post.save }
  end
end
