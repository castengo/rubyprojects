class AddShortTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :short_type, :string
  end
end
