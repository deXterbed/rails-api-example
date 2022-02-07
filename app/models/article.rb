class Article < ApplicationRecord
  validates :title, :content, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
