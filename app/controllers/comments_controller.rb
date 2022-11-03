# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[destroy edit update]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
  end

  def destroy
    if @comment.destroy
      @id = params[:id]
      @flash = 'Comment was deleted successfully.'
    else
      @flash = 'Comment was not deleted.'
    end
  end

  def edit
    @post = @comment.post
    render :edit
  end

  def update
    return unless @comment.update(comment_params)

    flash[:notice] = 'Comment was updated successfully.'
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
