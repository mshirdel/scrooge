class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :item_type

      t.timestamps
    end
  end
end
