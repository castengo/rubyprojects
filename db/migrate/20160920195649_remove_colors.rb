class RemoveColors < ActiveRecord::Migration
  def change
    drop_table :colors, force: :cascade
    remove_index :shades, :color_id
    add_column :shades, :colors_array, :string
  end
end
