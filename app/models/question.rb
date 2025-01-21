class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :user_answers, dependent: :restrict_with_error

  validates :content, presence: true

  before_destroy :prevent_destroy_if_has_answers

  private

  def prevent_destroy_if_has_answers
    if user_answers.exists?
      errors.add(:base, "Câu hỏi này đã được lưu trong kết quả làm bài của một người dùng nào đó. Không thể xóa!")
    end
  end
end
