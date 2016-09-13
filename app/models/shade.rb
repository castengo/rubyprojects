class Shade < ActiveRecord::Base
  belongs_to :product
  belongs_to :color

  # in progress
  def close_shades(hrange, srange, lrange)
    close_shades_ids = Color.joins(:shades).close_colors(color,hrange,srange,lrange).where.not(:shades => {:id => id}).pluck(:'shades.id').
    c
    hash = {}
    close_shades_ids
  	# Shade.where.not(:id => id).where(:color_id => close_colors_ids).group(:product_id)
  end

end
