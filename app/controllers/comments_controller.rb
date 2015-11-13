class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to @post
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      if current_user == @comment.user
      else
        flash[:comment_alert] = "You do not own this comment."
        redirect_to @post
      end

  end

  def show
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id]).update(comment_params)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
      redirect_to @post
    else
      flash[:comment_alert] = "You do not own this comment."
      redirect_to @post
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
