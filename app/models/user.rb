require 'openssl'

class User < ApplicationRecord
  # Параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  FORMAT_EMAIL = /\A[a-z*\.]+[a-z*]+@[a-z*\.]+[a-z*]+\z/
  FORMAT_USERNAME = /\A[\w]+\z/

  has_many :questions

  before_validation :username_downcase
  before_save :encrypt_password

  # Валидация
  validates_presence_of :email, :username, on: :create
  validates_uniqueness_of :email, :username, on: :create
  # валидация на email
  validates_format_of :email, :with => FORMAT_EMAIL, on: :create
  # валидация формата юзернейма пользователя (только латинские буквы, цифры, и знак _)
  validates_format_of :username, :with => FORMAT_USERNAME, on: :create
  # валидация максимальной длины юзернейма пользователя
  validates_length_of :username, :maximum => 40, on: :create

  # Добавляем виртуальный пароль
  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password, on: :create

  private

  def username_downcase
    self.username = username.downcase
  end

  def encrypt_password
    if self.password.present?
      # создаем т.н. "соль" - рандомная строка, усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      # создаем хэш пароля - длинная уникальная строка, из которой невозможно
      # восстановить исходный пароль
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  # Служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим кандитата по email
    # ОБРАТИТЕ ВНИМАНИЕ - сравнивается password_hash, а оригинальный пароль так никогда
    # и нигде не сохраняется!
    if user.present? && user.password_hash == User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end
