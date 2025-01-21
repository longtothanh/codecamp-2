class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :test

  has_many :user_answers, dependent: :destroy

  validates :score, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
