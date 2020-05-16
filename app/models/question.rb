class Question < ApplicationRecord

  belongs_to :user

  # Валидация
  validates_presence_of :text, on: :create
  # валидация максимальной длины текста вопроса
  validates_length_of :text, :maximum => 255
end
