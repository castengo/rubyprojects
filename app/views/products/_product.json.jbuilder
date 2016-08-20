json.extract! product, :id, :name, :description, :photo_url, :price, :brand_id, :created_at, :updated_at
json.url product_url(product, format: :json)