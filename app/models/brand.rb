class Brand < ApplicationRecord
	has_many :products, dependent: :destroy

	def self.search(name)
	    search_name = "%" + name.downcase + "%"
	    @brands = Brand.where("lower(name) LIKE ?", search_name)
	end
end
