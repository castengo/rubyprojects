class AddHslToShades < ActiveRecord::Migration
  def change
    add_column :shades, :h, :integer
    add_column :shades, :s, :integer
    add_column :shades, :l, :integer
    remove_column :colors, :h, :integer
    remove_column :colors, :s, :integer
    remove_column :colors, :l, :integer
    remove_column :colors, :hex, :string
    add_column :colors, :color_group, :string
    add_column :products, :multiple_colors, :boolean
  end
end
