class AddIndexToUserItemships < ActiveRecord::Migration
  def change
    add_index :user_itemships, :item_id
    add_index :user_itemships, :user_id
  end
end