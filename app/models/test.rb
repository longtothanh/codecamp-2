class Test < ApplicationRecord
    has_many :questions, dependent: :destroy

    validates :title, presence: true, uniqueness: { case_sensitive: false, message: "đã tồn tại" }
    validates :description, presence: true
end
