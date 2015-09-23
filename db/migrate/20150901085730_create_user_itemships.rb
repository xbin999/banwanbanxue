class CreateUserItemships < ActiveRecord::Migration
  def change
    create_table :user_itemships do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
