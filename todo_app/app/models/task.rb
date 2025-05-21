class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  validates :title, :due_date, presence: true

  scope :completed, -> { where(completed: true) }
  scope :due_soon, -> { where('due_date < ?', 3.days.from_now) }
end
