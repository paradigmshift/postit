class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    redirect_to post_path(@post) if current_user != @post.creator
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.find(session[:user_id])

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params) && current_user == @post.creator
      flash[:notice] = "Your post was updated"
      redirect_to post_path(@post)
    else
      flash[:error] = "You can only edit your own posts!"
      render :edit
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: @post)
    flash[:error] = "Cannot vote twice!" if !@vote.valid?

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_user
    if !logged_in?
      flash[:error] = "You are not logged in!"
      redirect_to login_path
    end
  end
end
