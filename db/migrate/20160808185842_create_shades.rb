class CreateShades < ActiveRecord::Migration
  def change
    create_table :shades do |t|
      t.string :name
      t.string :finish
      t.references :product, index: true, foreign_key: true
      t.references :color, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
