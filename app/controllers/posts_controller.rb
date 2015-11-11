class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def create
    @post = Post.create(post_params)
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
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
