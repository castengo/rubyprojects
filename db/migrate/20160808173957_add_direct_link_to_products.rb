class AddDirectLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :direct_link, :string
    add_column :products, :application, :string
  end
end
