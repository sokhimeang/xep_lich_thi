class CreateClassUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :class_users do |t|
      t.integer :user_id
      t.integer :class_id

      t.timestamps
    end
    add_index :class_users, [:user_id, :class_id], unique: true
  end
end
