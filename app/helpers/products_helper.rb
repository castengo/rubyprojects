module ProductsHelper
	def format_price(price)
		precise_price = number_with_precision(price, precision: 2)
		"$#{precise_price}"
	end
end
