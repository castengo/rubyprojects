class ColorsController < ApplicationController
	before_action :set_color, only: [:show]
	#get colors
	def index

		if !params[:product_type].nil?
	      @shades = Color.joins(:products).where("lower(products.product_type) LIKE '%#{params[:product_type]}%'").order(:h)
		else
    		@colors = Color.all.order(:l)
				@red_yellow_colors = Color.where(h: 8..60).order(:l, :s, :h)
				@green_colors = Color.where(h: 61..156).order(:l, :s, :h)
				@blue_colors = Color.where(h: 157..252).order(:l, :s, :h)
				@purple_pink_colors = Color.where(h: 253..324).order(:l, :s, :h)
				@pink_red_colors = Color.where(h: [325..360] + [1..7]).order(:l, :s, :h)

				#testing browns
				@first = Color.where(h: 3..25)
				@cool_browns = @first.where(s: 1..30).order(:l, :s, :h)
				@browns = @first.where(s: 31..55).order(:l, :s, :h)
				@oranges = @first.where(s: 56..100).order(:l, :s, :h)
				@not_browns = Color.where.not(:id => @first).order(:l, :s, :h)
	    end

	    respond_to do |format|
	      format.html
	      format.js
	    end

	end

	def show
		@spot_on_colors = Color.close_colors(@color,10,5,2)
		@close_call_colors = Color.close_colors(@color,30,20,10).where.not(id: @spot_on_colors.pluck(:id)).limit(9)
	end

	private

	def set_color
		@color = Color.find(params[:id])
	end

end
