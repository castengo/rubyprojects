class CreateLooks < ActiveRecord::Migration

  def change
    create_table :accounts do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :accounts_products, id:false do |t|
      t.belongs_to :account, index: true
      t.belongs_to :product, index: true
    end

    create_table :accounts_shades, id:false do |t|
      t.belongs_to :account, index: true
      t.belongs_to :shade, index: true
    end

    create_table :accounts_looks, id:false do |t|
      t.belongs_to :account, index: true
      t.belongs_to :look, index: true
    end

    create_table :profiles do |t|
      t.string :about
      t.string :avatar_url
      t.string :website_url
      t.string :instagram_url
      t.string :youtube_url
      t.string :facebook_url
      t.string :twitter_url
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :looks do |t|
      t.string :name
      t.string :caption
      t.string :image_url
      t.string :tags
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :looks_shades, id:false do |t|
      t.belongs_to :look, index: true
      t.belongs_to :shade, index: true
    end

  end

end
