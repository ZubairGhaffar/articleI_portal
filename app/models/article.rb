class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :drafts, -> { where(published: false) }

  def excerpt(length = 150)
    content.truncate(length)
  end
end