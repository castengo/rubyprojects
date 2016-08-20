class AddHexColorToShades < ActiveRecord::Migration
  def change
    add_column :shades, :hex_color, :string
  end
end
