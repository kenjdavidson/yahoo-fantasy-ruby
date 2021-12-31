class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :location
      t.string :image

      t.timestamps
    end
    add_index :users, :uid
  end
end
