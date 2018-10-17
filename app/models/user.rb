class User < ApplicationRecord
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  mount_uploader :image, ImageUploader

  has_many :room_users
  has_many :rooms, through: :room_users

  before_save :email_downcase, :code_upcase
  validates :code, presence: true,
    length: {maximum: Settings.user.code.max_length,
             minimum: Settings.user.code.min_length},
    uniqueness: {case_sensitive: false}
  validates :name,  presence: true,
    length: {maximum: Settings.user.name.max_length,
             minimum: Settings.user.name.min_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length}, allow_nil: true

  scope :order_by_code, ->{order code: :asc}
  scope :search,
    ->(code){where("code LIKE ? OR name LIKE ?", "%#{code}%", "%#{code}%")}

  private

  def email_downcase
    email.downcase!
  end

  def code_upcase
    code.upcase!
  end
end
