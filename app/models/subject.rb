class Subject < ApplicationRecord
  has_many :rooms
  has_many :user_subjects
  has_many :users, through: :user_subjects

  before_save :code_upcase
  validates :code, presence: true,
    uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :exam_during, presence: true,
    inclusion: (Settings.subject.exam.min_during)..
      (Settings.subject.exam.max_during)

  scope :order_by_code, ->{order code: :asc}
  scope :search,
    ->(code){where("code LIKE ? OR name LIKE ?", "%#{code}%", "%#{code}%")}

  private

  def code_upcase
    code.upcase!
  end
end
