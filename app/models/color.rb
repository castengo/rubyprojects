class Color < ActiveRecord::Base
	before_save :normalize_color, :to_hsl

	has_many :shades
	has_many :products, through: :shades

end
