# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images, attached: true, content_type: ['image/png', 'image/jpeg']
end
