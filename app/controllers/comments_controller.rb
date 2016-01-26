class CommentsController < ApplicationController
  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Comment successfully posted"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: @comment)
    flash[:error] = "Cannot vote twice!" if !@vote.valid?
    redirect_to :back
  end
end
