class LikesController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    @like = @post.likes.new(author: current_user)

    if @like.save
      flash[:success] = 'Like added!'
      redirect_to user_post_path(current_user, @like.post)
    else
      flash[:errors] = @like.errors.full_messages
    end
  end
end
