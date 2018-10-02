class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :code
      t.string :name
      t.integer :exam_during

      t.timestamps
    end
    add_index :subjects, :code, unique: true
  end
end
