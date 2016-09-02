class AddPositionToShades < ActiveRecord::Migration
  def change
    add_column :shades, :position, :integer
    add_column :products, :shades_group, :string
  end
end
