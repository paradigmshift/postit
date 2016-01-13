class SearchController < ApplicationController

  def index
    @results = Post.search(params[:q])
  end

end
