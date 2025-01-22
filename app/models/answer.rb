class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :correct, inclusion: { in: [true, false], message: "Giá trị đúng/sai phải là true hoặc false." }
  validate :at_least_one_correct_answer, on: :create

  private

  def at_least_one_correct_answer
    return unless question && correct

    if question.answers.where(correct: true).exists?
      errors.add(:base, "Câu hỏi này đã có câu trả lời đúng.")
    end
  end
end
