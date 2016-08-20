class Product < ActiveRecord::Base
  belongs_to :brand

  has_many :shades, dependent: :destroy
  has_many :colors, through: :shades

  validates :name, presence: true
  
  accepts_nested_attributes_for :shades
  
  def find_matching_palettes
  	matching_colors = [] #id of colors that match the product
  	colors.each do |color|
  		matching_colors.push(Color.close_colors(color,10).pluck(:id))
  	end
  	Product.joins(:shades).where.not(:id => id).where(:product_type => "Eye Shadow Palette", :shades => {:color_id => matching_colors}).uniq
  end
end
