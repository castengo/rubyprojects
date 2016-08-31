class AddViewsToModels < ActiveRecord::Migration
  def change
  	add_column :brands, :views, :integer
    add_column :products, :views, :integer
    add_column :shades, :views, :integer
    add_column :colors, :views, :integer
  end
end
