# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :description, presence: true, length: { in: 5..50 }
  validates :images, attached: true, content_type: ['image/png', 'image/jpeg']
end
