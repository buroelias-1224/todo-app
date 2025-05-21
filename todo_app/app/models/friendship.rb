class Friendship < ApplicationRecord
  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }

  validates :requester_id, uniqueness: { scope: :receiver_id }
  validate :not_self
  validate :not_duplicate

  def not_self
    errors.add(:receiver_id, "can't be yourself") if requester_id == receiver_id
  end

  def not_duplicate
    if Friendship.exists?(requester_id: requester_id, receiver_id: receiver_id) ||
       Friendship.exists?(requester_id: receiver_id, receiver_id: requester_id)
      errors.add(:base, "Already friends or request sent")
    end
  end
end
