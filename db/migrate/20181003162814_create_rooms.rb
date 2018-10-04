class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :code
      t.integer :capacity

      t.timestamps
    end
    add_index :rooms, :code, unique: true
  end
end
