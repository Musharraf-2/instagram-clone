# frozen_string_literal: true

class StoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :find_story, only: %i[show destroy]

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      flash[:notice] = 'Story was created successfully.'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Story was not created.'
      render :new
    end
  end

  def show; end

  def destroy
    if @story.destroy
      flash[:notice] = 'Story was deleted successfully.'
    else
      flash[:alert] = 'Story was not deleted.'
    end
    redirect_to posts_path
  end

  private

  def story_params
    if params.key?(:story)
      params.require(:story).permit(images: [])
    else
      params.permit(images: [])
    end
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
