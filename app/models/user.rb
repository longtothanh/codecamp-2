class User < ApplicationRecord
  before_validation :set_default_type, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  self.inheritance_column = :_type_disabled

  enum type: { user: 0, admin: 1 }

  validates :type, presence: true
  validates :name, presence: true

  private

  def set_default_type
    self.type ||= :user
  end
end
