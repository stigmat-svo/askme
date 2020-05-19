class Question < ApplicationRecord
  belongs_to :user

  # Валидация
  validates :text, presence: true, length: { maximum: 255 }
end
