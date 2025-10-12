class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :drafts, -> { where(published: false) }

  # Search scope
  scope :search, ->(query) {
    return all if query.blank?

    search_term = query.to_s.strip.gsub(/\s+/, " ")
    return all if search_term.blank?

    where("title ILIKE ? OR content ILIKE ?", "%#{search_term}%", "%#{search_term}%")
  }

  def excerpt(length = 150)
    content.truncate(length)
  end
end
