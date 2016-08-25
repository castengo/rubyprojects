class Brand < ActiveRecord::Base
	has_many :products, dependent: :destroy

	def self.search(name)
	    search_name = "%" + name + "%"
	    @brands = Brand.where("name LIKE ?", search_name)
	end
end
