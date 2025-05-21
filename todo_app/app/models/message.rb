class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validate :must_be_friends

  def must_be_friends
    unless Friendship.exists?(requester: sender, receiver: receiver, status: 'accepted') ||
           Friendship.exists?(requester: receiver, receiver: sender, status: 'accepted')
      errors.add(:base, 'You must be friends to chat')
    end
  end
end
