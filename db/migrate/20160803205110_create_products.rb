class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :photo_url
      t.decimal :price, precision: 6, scale: 2
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
