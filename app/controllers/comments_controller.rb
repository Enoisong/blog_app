class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      flash[:success] = 'Comment added!'
      redirect_to user_post_path(current_user, @comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
