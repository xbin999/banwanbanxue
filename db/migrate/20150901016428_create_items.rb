class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end

    add_column :records, :item_id, :integer
    add_index :records, :item_id
  end
end
