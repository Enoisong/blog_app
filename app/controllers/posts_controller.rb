class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = Post.find_by_id(params[:id])
    @current_user = current_user
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.persisted?
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
