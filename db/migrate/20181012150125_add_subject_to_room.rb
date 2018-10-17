class AddSubjectToRoom < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :subject, foreign_key: true
  end
end
