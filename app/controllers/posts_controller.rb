class PostsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @user.posts
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @post = @user.posts.find_by_id(params[:post_id])
  end
end