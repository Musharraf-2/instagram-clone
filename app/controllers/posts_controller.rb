# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_post, only: %i[edit update destroy show]

  def index
    @posts = Post.order(created_at: :desc)
    @stories = Story.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post was created successfully.'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post was not created.'
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully.'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post was not updated.'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      @id = params[:id]
      @flash = 'Post was deleted successfully.'
    else
      @flash = 'Post was not deleted.'
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:description, images: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
