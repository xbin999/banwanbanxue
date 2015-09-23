class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :value
      t.date :created
      t.text :description

      t.timestamps null: false
    end

    add_column :records, :user_id, :integer
    add_index :records, :user_id
  end
end
