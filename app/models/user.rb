class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Subscription relationships
  has_many :subscriptions, foreign_key: 'subscriber_id', dependent: :destroy
  has_many :subscribed_to_users, through: :subscriptions, source: :subscribed_to
  
  has_many :reverse_subscriptions, foreign_key: 'subscribed_to_id', 
                                   class_name: 'Subscription', 
                                   dependent: :destroy
  has_many :subscribers, through: :reverse_subscriptions, source: :subscriber

  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\+?[\d\s\-\(\)]+\z/, message: "should be a valid phone number" }

  has_one_attached :avatar

  # Returns the users that this user is subscribed to
  def subscribed_to_users
    User.joins(:reverse_subscriptions).where(subscriptions: { subscriber_id: id })
  end

  # Returns the users who are subscribed to this user
  def subscribers
    User.joins(:subscriptions).where(subscriptions: { subscribed_to_id: id })
  end

  # Check if current user is subscribed to another user
  def subscribed_to?(user)
    subscriptions.exists?(subscribed_to_id: user.id)
  end
end