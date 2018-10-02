class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :code
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :code, unique: true
  end
end
