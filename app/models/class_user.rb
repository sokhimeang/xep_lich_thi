class ClassUser < ApplicationRecord
  belongs_to :user
  belongs_to :class

  validates_uniqueness_of :user_id, scope: :class_id
end
