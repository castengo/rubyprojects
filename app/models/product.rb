class Product < ActiveRecord::Base
  belongs_to :brand

  has_many :shades, dependent: :destroy
  has_many :colors, through: :shades

  validates :name, presence: true
  
  accepts_nested_attributes_for :shades

  scope :by_price, -> { order(:price) }
  
  def find_matching_palettes
  	matching_colors = [] #id of colors that match the product
  	colors.each do |color|
      close_colors_ids = Color.close_colors(color,10,5,2).pluck(:id)
      close_colors_ids.each do |id|
        if !matching_colors.include?(id)
  		     matching_colors.push(id)
        end
      end
  	end
  	Product.joins(:shades).where.not(:id => id).where(:product_type => "Eye Shadow Palette", :shades => {:color_id => matching_colors}).uniq
  end

  def self.search(name)
      search_name = "%" + name + "%"
      @products = Product.where("name LIKE ?", search_name)
  end

end
