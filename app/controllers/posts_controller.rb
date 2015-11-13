class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @post = Post.all
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save
    redirect_to posts_path
  end

  def new
    @post = Post.new
    @comment = @post.comments.new
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @post.save
    redirect_to @post
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    if current_user == @post.user

    else
      flash[:alert] = "You don't own this blog."
      render 'show'
    end

  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      redirect_to posts_path
    else
      flash[:alert] = "You don't own this blog."
      redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user)
  end

end
