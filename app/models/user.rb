# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :validatable, :registerable

  has_one_attached :image

  validates :image, attached: true, content_type: ['image/png', 'image/jpeg']
  validates :username, presence: true, uniqueness: true
  validates :is_public, presence: true

  before_validation :set_status

  private

  def set_status
    self.is_public = true
  end
end
