class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'
  belongs_to :subscribed_to, class_name: 'User'
  
  validates :subscriber_id, uniqueness: { scope: :subscribed_to_id, message: "is already subscribed to this author" }
  
  # Prevent users from subscribing to themselves
  validate :cannot_subscribe_to_self

  private

  def cannot_subscribe_to_self
    if subscriber_id == subscribed_to_id
      errors.add(:subscribed_to, "cannot subscribe to yourself")
    end
  end
end