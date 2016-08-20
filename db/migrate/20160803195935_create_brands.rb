class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :website_url
      t.string :logo_url

      t.timestamps null: false
    end
  end
end
