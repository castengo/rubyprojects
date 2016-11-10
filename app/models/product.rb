class Product < ActiveRecord::Base
  belongs_to :brand

  has_many :shades, dependent: :destroy

  accepts_nested_attributes_for :shades, :reject_if => lambda { |a| a[:hex_color].blank? }, :allow_destroy => true

  # scope :by_price, -> { order(:price) }

  # not using I think
  def find_matching_products
    query = ""
    products = ["eye", "lip", "face", "brow"]
    products.each do |prod|
      if product_type.downcase.include?(prod)
        query = prod
      end
    end
  	Product.where.not(:id => id).joins(:shades).where("lower(product_type) LIKE '%#{query}%'").group(:product_id).order('count_product_id DESC').count('product_id')
  end


  def self.search(query)
    formatted_query= "%" + query.downcase + "%"
    joins(:brand).where("lower(brands.name) LIKE ? OR lower(products.name) LIKE ? OR lower(products.product_type) LIKE ? ", formatted_query, formatted_query, formatted_query)
  end

end
