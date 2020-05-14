require 'openssl'

class User < ApplicationRecord

  # Параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  # Валидация
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  # валидация на email
  validates :email, format: {
      with: /[a-z*\.]+[a-z*]+@[a-z*\.]+[a-z*]/m, message: "Неправильный формат email!"
  }
  # валидация максимальной длины юзернейма пользователя
  validates :username, length: { maximum: 40 }

  # Добавляем виртуальный пароль
  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

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


  # # Коллбэки
  # before_validation :before_validation
  # after_validation :after_validation
  # before_save :before_save
  # before_create :before_create
  # after_create :after_create
  # after_save :after_save
  #
  # before_update :before_update
  # after_update :after_update
  #
  # before_destroy :before_destroy
  # after_destroy :after_destroy
  #
  # # Метод вызова коллбэков
  # private
  #
  # %w(validation save create update destroy).each do |action|
  #   %w(before after).each do |time|
  #     define_method("#{time}_#{action}") do
  #       puts "------> #{time} #{action}"
  #     end
  #   end
  # end

end
