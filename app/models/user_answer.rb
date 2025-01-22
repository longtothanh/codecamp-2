class UserAnswer < ApplicationRecord
  belongs_to :user_exam
  belongs_to :question
  belongs_to :answer, optional: true

  validates :times, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
