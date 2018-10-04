class Room < ApplicationRecord
  has_many :class_users
  has_many :users, through: :class_users

  validates :code, presence: true,
    length: {maximum: Settings.room.code.max_length,
             minimum: Settings.room.code.min_length},
    uniqueness: true
  validates :capacity, presence: true,
    inclusion: (Settings.room.capacity.min_num)..
      (Settings.room.capacity.max_num)

  scope :search, ->(code){where("code LIKE ?", "%#{code}%").order(code: :asc)}
  scope :order_by_code, ->{order code: :asc}
end
