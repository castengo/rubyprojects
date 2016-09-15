class Color < ActiveRecord::Base
	before_save :to_hsl

	has_many :shades
	has_many :products, through: :shades


	#find matching colors to specified precision
	def self.close_colors(color, hrange, srange, lrange)
		close_colors = Color.where(h: get_h_range(color.h,hrange), s: get_sl_range(color.s,srange), l: get_sl_range(color.l,lrange))
		close_colors.order("ABS(colors.h-h)")
	end


	def self.get_h_range(value,range)
		max_value = value + range > 360 ? 360 : value + range
		min_value = value - range < 0 ? 0 : value - range
		min_value..max_value
	end

	def self.get_sl_range(value,range)
		max_value = value + range > 100 ? 100 : value + range
		min_value = value - range < 0 ? 0 : value - range
		min_value..max_value
	end

	private

	def to_hsl
		if !hex.nil?
			rgb = {}
			match = hex.match /(..)(..)(..)/
			rgb[:r] = match[1].hex/255.0
			rgb[:g] = match[2].hex/255.0
			rgb[:b] = match[3].hex/255.0

			lum = sat = hue = 0
			rgb_max = rgb.values.max
			rgb_min = rgb.values.min
			#determine luminance
			lum = (rgb_min + rgb_max)/2.0
			if rgb_min != rgb_max
				# determine saturation
				d = rgb_max - rgb_min
				if lum > 0.5
					sat = d/(2.0 - rgb_max - rgb_min)
				else
					sat = d/(rgb_max + rgb_min)
				end
				# determine hue
				case rgb.key(rgb_max)
				when :r
					hue = (rgb[:g] - rgb[:b])/d
					# (rgb[:g] < rgb[:b] ? 6 : 0)
				when :g
					hue = (rgb[:b] - rgb[:r])/d + 2.0
				when :b
					hue = (rgb[:r] - rgb[:g])/d + 4.0
				end
				hue *= 60.0
				if hue < 0
					hue += 360.0
				end
			end
			self[:h] = hue.round
			self[:s] = (sat*100).round
			self[:l] = (lum*100).round
		else
			"hex is nil"
		end
	end

end
