class Color < ActiveRecord::Base
	before_save :to_rgb

	has_many :shades
	has_many :products, through: :shades 


	#find matching colors to specified precision
	def self.close_colors(color, range)
		close_colors = Color.where(r: get_range(color.r,range), g: get_range(color.g,range), b: get_range(color.b,range))
		close_colors.order("ABS(#{color.r}-r)") 
	end

	#makes hash with product and occurrences
	def self.product_match(color,range)
		product_match = {}
		self.close_colors(color,range).each do |shade|
			if product_match.empty?
				product_match[shade.product] = 1
			elsif product_match[shade.product]
				product_match[shade.product] += 1
			else
				product_match[shade.product] = 1
			end
		end
		return product_match.sort_by{ |k,v| v }.reverse
	end

	def self.get_range(value,range)
		max_value = value + range > 255 ? 255 : value + range
		min_value = value - range < 0 ? 0 : value - range
		min_value..max_value
	end

	private
	
	def to_rgb
		if !hex.nil?
			match = hex.match /(..)(..)(..)/
			self[:r] = match[1].hex
			self[:g] = match[2].hex
			self[:b] = match[3].hex
		else
			self[:hex] = "#{r.to_s(16)}#{g.to_s(16)}#{b.to_s(16)}"
		end
	end
end
