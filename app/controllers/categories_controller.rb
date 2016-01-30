class CategoriesController < ApplicationController
  before_action :require_admin, only: [:create]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Your category was created"
      redirect_to :root
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
