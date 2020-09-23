class PostsController < ApplicationController
  def index
    @users = User.all
    @elements = Post.all
  end

  def create
    @user = User.new(name: params[:name])
    @user.save
    redirect_to('/posts/index')
  end
end
