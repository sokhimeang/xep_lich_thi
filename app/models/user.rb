class User < ApplicationRecord
  validates :code, presence: true,
    length: {maximum: Settings.user.code.max_length,
      minimum: Settings.user.code.min_length},
    uniqueness: {case_sensitive: false}
  validates :name,  presence: true,
    length: {maximum: Settings.user.name.length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length}, allow_nil: true

  scope :order_by_code, -> {order code: :asc}
end
