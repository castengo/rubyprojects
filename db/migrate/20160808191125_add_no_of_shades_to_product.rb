class AddNoOfShadesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :no_of_shades, :integer
  end
end
