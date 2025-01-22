class Test < ApplicationRecord
    has_many :user_exams, dependent: :destroy
    has_many :users, through: :user_exams
    has_many :questions, dependent: :destroy

    validates :title, presence: true, uniqueness: { case_sensitive: false, message: "đã tồn tại" }
    validates :description, presence: true
end
