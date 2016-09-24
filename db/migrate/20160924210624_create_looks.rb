class CreateLooks < ActiveRecord::Migration
  def change
    create_table :looks do |t|
      t.string :name
      t.string :image_url
      t.string :tags
      t.string :artist

      t.timestamps null: false
    end

    create_table :looks_shades, id:false do |t|
      t.belongs_to :looks, index: true
      t.belongs_to :shades, index: true
    end

  end

end
