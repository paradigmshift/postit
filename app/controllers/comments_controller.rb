class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Comment successfully posted"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

 end
end
