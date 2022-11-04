# frozen_string_literal: true

class StoriesCleanupJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.destroy
  end
end
