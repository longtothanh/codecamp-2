class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :content, presence: true
  validates :answers, length: { in: 2..5, message: "must have between 2 and 5 answers" }
end
