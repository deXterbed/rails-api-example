class Article < ApplicationRecord
  validates :title, :content, presence: true
  validates :slug, presence: true, uniqueness: true
end
