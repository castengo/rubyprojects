class Product < ActiveRecord::Base
  belongs_to :brand

  has_many :shades, dependent: :destroy

  accepts_nested_attributes_for :shades, :reject_if => lambda { |a| a[:hex_color].blank? }, :allow_destroy => true

  # scope :by_price, -> { order(:price) }


  def find_matching_products
    query = ""
    products = ["eye", "lip", "face"]
    products.each do |prod|
      if product_type.downcase.include?(prod)
        query = prod
      end
    end
  	Product.where.not(:id => id).joins(:shades).where("lower(product_type) LIKE '%#{query}%'").where(:shades => {:color_id => matching_colors}).group(:product_id).order('count_product_id DESC').count('product_id')
  end

  #in construction
  def available_product_types
    query = ""
    products = ["eye", "lip", "face"]
    products.each do |prod|
      if product_type.downcase.include?(prod)
        query = prod
      end
    end
    Product.where("lower(product_type) LIKE '%#{query}%'").select(:product_type).uniq
  end

  #id of colors that match the product
  def matching_colors
    matching_colors = []
    colors.each do |color|
      close_colors_ids = Color.close_colors(color,10,5,2).pluck(:id) #10,5,2
      close_colors_ids.each do |id|
        if !matching_colors.include?(id)
           matching_colors.push(id)
        end
      end
    end
    matching_colors
  end

  def self.search(name)
      search_name = "%" + name.downcase + "%"
      @products = Product.where("lower(name) LIKE ? ", search_name)
  end

end
