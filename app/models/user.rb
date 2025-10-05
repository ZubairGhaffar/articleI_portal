class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  before_validation :set_username, on: :create

  private

  def set_username
    self.username = email.split('@').first if username.blank? && email.present?
  end
end