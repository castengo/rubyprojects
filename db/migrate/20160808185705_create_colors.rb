class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :hex
      t.integer :r
      t.integer :b
      t.integer :g

      t.timestamps null: false
    end
  end
end
